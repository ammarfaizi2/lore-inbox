Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291771AbSBHTiE>; Fri, 8 Feb 2002 14:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291772AbSBHThz>; Fri, 8 Feb 2002 14:37:55 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:906 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S291771AbSBHThn>; Fri, 8 Feb 2002 14:37:43 -0500
Message-ID: <3C642ABE.4B808E01@nortelnetworks.com>
Date: Fri, 08 Feb 2002 14:45:02 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: trying to track down kernel stack overflow
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been doing some messing around and got the following on the serial console:

Kernel stack overflow in process ca2da000, r1=ca2da390
NIP: 90015D6C XER: 00000000 LR: 90015D68 REGS: ca2da2c0 TRAP: 0500
MSR: 00009032 [EEIRDRME]
Unable to handle kernel paging request at virtual address 2442244f (error
40000000)
NIP: 90007ED0 XER: 20000000 LR: 90007EC8 REGS: 901971f8 TRAP: 3000
MSR: 00001032 [IRDRME]
Unable to handle kernel paging request at virtual address 2442244f (error
40000000)
NIP: 90007ED0 XER: 20000000 LR: 90007EC8 REGS: 901970b8 TRAP: 3000
MSR: 00001032 [IRDRME]
Unable to handle kernel paging request at virtual address 2442244f (error
40000000)
NIP: 90007ED0 XER: 20000000 LR: 90007EC8 REGS: 90196f78 TRAP: 3000
MSR: 00001032 [IRDRME]
Unable to handle kernel paging request at virtual address 2442244f (error
40000000)
NIP: 90007ED0 XER: 20000000 LR: 90007EC8 REGS: 90196e38 TRAP: 3000
MSR: 00001032 [IRDRME]

<...snip...>


How do I go about figuring exactly what code this matches?  I've got the vmlinux
file available...

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
