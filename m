Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283390AbRLDUEw>; Tue, 4 Dec 2001 15:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281664AbRLDUDP>; Tue, 4 Dec 2001 15:03:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:22537 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282910AbRLDUCL> convert rfc822-to-8bit; Tue, 4 Dec 2001 15:02:11 -0500
Date: Tue, 4 Dec 2001 16:45:26 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops: 0000 with kernel 2.4.17pre2
In-Reply-To: <E16BKMt-0004SE-00@mrvdom00.schlund.de>
Message-ID: <Pine.LNX.4.21.0112041644310.19750-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Dec 2001, Christian Bornträger wrote:

> I found this in my logs.
> I have no idea, why the log says not tainted, because I am quite sure that 
> the nvidia-driver was loaded at this moment.
> It seems that this happened while trying to kill a quake3-session.(I noticed 
> today, that there is a linux version..... ;-))
> 
> I don´t know if I should blame the nvidia-driver, but please have a look at 
> it, because there were some other oops messages with 2.4.16 in the LKML.
> The call trace has functions of the VM, of the file system layer and reiserfs.
> 
> 
> greetings
> 
> 4e 08 8b 41 04 89
> Dec  4 16:48:12 cubus kernel:  <6>NVRM: AGPGART: freed 16 pages
				    ^^^
> Dec  4 16:48:14 cubus kernel:  printing eip:
> Dec  4 16:48:14 cubus kernel: e097134a

It really seems to be the nvidia driver which is causing problems. 

