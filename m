Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135952AbRDTP6m>; Fri, 20 Apr 2001 11:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135956AbRDTP6d>; Fri, 20 Apr 2001 11:58:33 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:51983 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135952AbRDTP6S> convert rfc822-to-8bit; Fri, 20 Apr 2001 11:58:18 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Francois Romieu <romieu@cogenit.fr>
Subject: Re: epic100 error
Date: Fri, 20 Apr 2001 17:57:54 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010417184552.A6727@core.devicen.de> <01042016050400.01202@antares> <20010420163343.B4702@se1.cogenit.fr>
In-Reply-To: <20010420163343.B4702@se1.cogenit.fr>
MIME-Version: 1.0
Message-Id: <01042017575400.01716@antares>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 April 2001 16:33, Francois Romieu wrote:
> Stefan Jaschke <s-jaschke@t-online.de> ecrit :
> > I copied epic100.c from 2.4.2 into the 2.4.4-pre4 tree and it compiles
> > and works without problems.
> > This gives me a workable solution :-)
>
> Thanks for the info.
> Now, why do you get so much Receive Queue Empty indications...

Now, this is a question for more knowledgable persons than me :-)

Another question I have is about the different driver versions that
are around. 
Till Harbaum <harbaum@telematik.informatik.uni-karlsruhe.de> just sent
me a driver which is directly from SMC:
> As i already mentioned in a posting, that for some reason didn't show up in 
> the list, i got a driver module source directly from SMC, that works fine 
> with 2.4.3 and has the ability to use the optical interface.
>  Till
It unpacks to
          18458 Jul 14  1999 copying
           1931 Mar  9 09:30 debug.h
          10451 Mar 12 13:39 list.h
         123761 Mar 13 16:05 lm.c
          11547 Mar 12 13:37 lm.h
          14872 Apr  5 11:35 lm.o
           4761 Apr 13  2000 lm_cfg.h
          29169 Mar 13 16:05 lm_epic.h
            335 Apr  5 17:14 makefile
          22096 Mar 13 16:06 mm.c
           4754 Mar 17  2000 mm.h
           3672 Apr  5 11:35 mm.o
            676 Mar 26 09:51 readme.txt
          21874 Apr  5 11:35 smcpwr2.o
          24572 Mar 13 16:14 um.c
           3550 Mar 13 16:08 um.h
           5628 Apr  5 11:34 um.o                    
and "copying" is the GPL. It seems to be a not yet released extension of the driver
available from http://www.smc.de/sites/support/download/PCI/9432/LINUX/src9432lu.zip.
Some changelog reads " 03/13/2001 Ling Yue     for linux kernel 2.4".

Is there communication between SMC and your group?
 
-- 
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
