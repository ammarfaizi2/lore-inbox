Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSDRUgU>; Thu, 18 Apr 2002 16:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314452AbSDRUgT>; Thu, 18 Apr 2002 16:36:19 -0400
Received: from 116.140.hh1.ip.foni.net ([212.7.140.116]:3844 "HELO
	debian.heim.lan") by vger.kernel.org with SMTP id <S314451AbSDRUgS>;
	Thu, 18 Apr 2002 16:36:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian Schoenebeck <christian.schoenebeck@epost.de>
To: linux-kernel@vger.kernel.org
Subject: power off (again)
Date: Thu, 18 Apr 2002 22:40:06 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020418201220.C6D6247B1@debian.heim.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> please cc me, I'm offlist <<<

Hi!

I'm still fighting the problem that power off doesn't work with one of our 
machines since moving from 2.2.19 to 2.4.7 kernel.

I compared both apm.c versions (1.13ac and 1.14) but there are no 'real'
changes to the functions involved in the shutdown process, except some
minor changes to macro definitions.

'cat /proc/apm' says '1.14 1.2 0x03 0x01 0xff 0x80 -1% -1 ?' which are all 
normal values for non-notebooks.

I'm a little bit stuck with this and I have no idea what to look for so hints 
would be highly appreciated!

Christian Schoenebeck

P.S. Yes, apm is supported by the bios, I have enabled apm, I tried real mode 
power off, I tried using apm as module and also tried acpi instead
