Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSEPQ5y>; Thu, 16 May 2002 12:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSEPQ5x>; Thu, 16 May 2002 12:57:53 -0400
Received: from [202.88.159.197] ([202.88.159.197]:30448 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S314446AbSEPQ5v>; Thu, 16 May 2002 12:57:51 -0400
Message-Id: <200205161714.g4GHETg12270@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
From: rpm <rajendra.mishra@timesys.com>
Reply-To: rajendra.mishra@timesys.com
Organization: Timesys
To: linux-kernel@vger.kernel.org
Subject: ADS Gcp 2.4.7 reboot  issue
Date: Thu, 16 May 2002 22:44:28 +0530
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all ,
	I had posted a message previously also and got some usefule info about the 
same topic . I have a ads graphic client plus board (Strong ARM SA1100 ) 
running 2.4.7 kernel. The problem is that a small c++ application which 
causes the system to reboot. What i guessed is that at some point of time 
some memory corruption is happening and it's causing the code to jump to the 
RSRR ( reset registers ) and reboot the system. I went to the 
/include/asm/arch/SA-1100.h file and changed the definition of the RSRR 
register from 0x90030000 to 0xE0030000. Now if i run the application for the 
first time, the board does not reboot   but 2 or  3 executions cause the 
board to reboot. 
      What i want to do is , to somehow find out at what point of time kernel 
is loosing control and  writing to RSRR register.  
       And is there any other way to reboot , other then writing to RSRR 
register.
      If someone has some clue, it will be helpfull   .

regards,
rpm 
 
