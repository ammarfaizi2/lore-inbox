Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318365AbSH0Cv4>; Mon, 26 Aug 2002 22:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318366AbSH0Cv4>; Mon, 26 Aug 2002 22:51:56 -0400
Received: from codepoet.org ([166.70.99.138]:25276 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318365AbSH0Cvz>;
	Mon, 26 Aug 2002 22:51:55 -0400
Date: Mon, 26 Aug 2002 20:56:16 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Chua <jchua@fedex.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] initrd >24MB corruption (fwd)
Message-ID: <20020827025616.GA6998@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Chua <jchua@fedex.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208271038450.25059-100000@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208271038450.25059-100000@boston.corp.fedex.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 27, 2002 at 10:49:13AM +0800, Jeff Chua wrote:
> 
> Alan,
> 
> Who else can help with this problem? I tried to write to Werner
> Almesberger <werner.almesberger@epfl.ch> (no such email) and Hans Lermen
> <lermen@fgan.de>, but no response from either.
> 
> I'm suspecting that somehow part of initrd is being corrupted during boot
> up or may be ungzip is not working properly, because I can definitely
> gzip/ungzip on all versions of running Linux for the ram.gz filesystem I
> created.  Again, the only difference between ram-18mb.gz (6MB) and
> ram-24mb.gz (8MB) is ram24.gz contains one extra file to fill up the
> filesystem to 90%.
> 
> Same bzImage, same ramdisk_size=28000, just different initrd files.
> ram-18mb.gz boots, ram-24mb.gz hangs.

How much total ram does your system have?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
