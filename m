Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289954AbSAWSKK>; Wed, 23 Jan 2002 13:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289955AbSAWSKA>; Wed, 23 Jan 2002 13:10:00 -0500
Received: from pop.gmx.de ([213.165.64.20]:45106 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289954AbSAWSJr>;
	Wed, 23 Jan 2002 13:09:47 -0500
Message-ID: <3C4EFC44.2FE720B0@gmx.net>
Date: Wed, 23 Jan 2002 19:09:08 +0100
From: root <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Console output for debugging
In-Reply-To: <3C4DF2AD.66BC3F6C@cicese.mx> <a2ksul$6v5$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:

> Followup to:  <3C4DF2AD.66BC3F6C@cicese.mx>
> By author:    Serguei Miridonov <mirsev@cicese.mx>
> In newsgroup: linux.dev.kernel
> >
> > Q: Is there any function in the kernel which I can call
> > safely from a module to print debug message on the console
> > screen?
> >
> > I don't want to use printk for some reasons. One of them is
> > that I want messages to appear on the screen immediately,
> > even from interrupt processing routines. Another is to be
> > able to see messages until the system freezes completely in
> > case of software or hardware bug.
> >
>
> Use printk.

But beware of some ioctls to which at least Suse defaults,
these can intercept the direct output to the console (and
let syslogd emulate the console output).

