Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316275AbSEKWfZ>; Sat, 11 May 2002 18:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316276AbSEKWfY>; Sat, 11 May 2002 18:35:24 -0400
Received: from web10404.mail.yahoo.com ([216.136.130.96]:12048 "HELO
	web10404.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316275AbSEKWfX>; Sat, 11 May 2002 18:35:23 -0400
Message-ID: <20020511223523.24046.qmail@web10404.mail.yahoo.com>
Date: Sun, 12 May 2002 08:35:23 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: OOPS 2.4.19-pre7-ac4 (Was: strange things in kernel 2.4.19-pre7-ac4 + preempt patch)
To: vda@port.imtp.ilyichevsk.odessa.ua, kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200205111737.g4BHbfY02535@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It seems like one bit error in eax. Maybe a NULL
> pointer got
> corrupted and now movzbl stumbles over it.
> 
> Bad RAM? Consider memtest86 run overnight.
> --
> vda 

I will but I dont have any such similar problem until 
2.4.19-pre7-ac4. The box is very stable; even with
2.4.19-pre7-ac4 if I did not exit X. 

ah, one more detail, actually the OOPS happened when
exiting X, not because of starting a new X server. The
other strange thing with 2.4.19-pre7-ac4 is it can not
turn off the computer if I run ` sudo  halt`  as a
child process of icewm, If I start a new terminal and
run  sudo  halt   ; X goes down and if during that I
press Alt + F1  the text screen appear and it can turn
off. I think this problem related to the OOPS ; 


How it is possible?
May be there is a change in the kernel setup, or
memory allocation etc..?

Regard,



=====
Steve Kieu

http://messenger.yahoo.com.au - Yahoo! Messenger
- A great way to communicate long-distance for FREE!
