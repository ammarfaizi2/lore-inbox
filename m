Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288720AbSADSf4>; Fri, 4 Jan 2002 13:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288719AbSADSfr>; Fri, 4 Jan 2002 13:35:47 -0500
Received: from kura.mail.jippii.net ([195.197.172.113]:29349 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S288716AbSADSfh> convert rfc822-to-8bit; Fri, 4 Jan 2002 13:35:37 -0500
Message-ID: <1200795.1010169416398.JavaMail.jackdeth@jippii.fi>
Date: Fri, 4 Jan 2002 20:36:56 +0200 (EET)
From: jackdeth@jippii.fi
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 & bttv: vmalloc failures with 1GB memory
Mime-Version: 1.0
Content-Type: text/plain; Charset=iso-8859-1; Format=Flowed
Content-Transfer-Encoding: 8BIT
X-Mailer: Jippii webmail - http://www.jippiigroup.com/
X-Originating-IP: 213.139.166.70/195.197.160.195
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm having problems using video capture under linux. i've tried several 
capturing programs using libavifile. i can sometimes get capturing to 
work right after reboot, but after using machine for some time 
(cache/buffers fill up etc?), it stops working and i get messages like 
this:

Jan  2 23:25:44 xxx kernel: bttv: vmalloc_32(4259840) failed
Jan  2 23:25:44 xxx kernel: bttv: vmalloc_32(4259840) failed
Jan  2 23:26:50 xxx last message repeated 13 times

currently i'm using stock kernel 2.4.17 with 4gb highmem support and 
bttv. my system is as follows:

athlonxp 1600+
epox 8kha+
1GB memory
bt878 tv-card

could this be related to the recent allocation and cache freeing problems?


please cc me on replys.

__
Tämän ilmaisen suomalaisen sähköpostin tarjosi http://www.jippii.fi/
Käy tutustumassa netin parhaaseen pelipaikkaan Pasimaailmaan.

