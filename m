Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283349AbRLDUxA>; Tue, 4 Dec 2001 15:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283424AbRLDUv3>; Tue, 4 Dec 2001 15:51:29 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:18149 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S283477AbRLDUt0> convert rfc822-to-8bit; Tue, 4 Dec 2001 15:49:26 -0500
Date: Tue, 4 Dec 2001 15:49:14 -0500 (EST)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Oops: 0000 with kernel 2.4.17pre2
In-Reply-To: <Pine.LNX.4.21.0112041644310.19750-100000@freak.distro.conectiva>
Message-ID: <Pine.A41.4.21L1.0112041547290.37960-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are these the latest (2313) drivers? I saw this last night as well and
updated to devfs-v199v2 immediately. I've since updated to v199v3 and
switched to nvgart and will be pushing my system pretty hard over the next
couple hours to try to reproduce it.

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Tue, 4 Dec 2001, Marcelo Tosatti wrote:

> On Tue, 4 Dec 2001, Christian Bornträger wrote:
> 
> > I found this in my logs.
> > I have no idea, why the log says not tainted, because I am quite sure that 
> > the nvidia-driver was loaded at this moment.
> > It seems that this happened while trying to kill a quake3-session.(I noticed 
> > today, that there is a linux version..... ;-))
> > 
> > I don´t know if I should blame the nvidia-driver, but please have a look at 
> > it, because there were some other oops messages with 2.4.16 in the LKML.
> > The call trace has functions of the VM, of the file system layer and reiserfs.
> > 
> > 
> > greetings
> > 
> > 4e 08 8b 41 04 89
> > Dec  4 16:48:12 cubus kernel:  <6>NVRM: AGPGART: freed 16 pages
> 				    ^^^
> > Dec  4 16:48:14 cubus kernel:  printing eip:
> > Dec  4 16:48:14 cubus kernel: e097134a
> 
> It really seems to be the nvidia driver which is causing problems. 

