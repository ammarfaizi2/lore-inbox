Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274070AbRI0XMN>; Thu, 27 Sep 2001 19:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274072AbRI0XME>; Thu, 27 Sep 2001 19:12:04 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:9110 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S274070AbRI0XL4>; Thu, 27 Sep 2001 19:11:56 -0400
Date: Thu, 27 Sep 2001 16:11:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac16
Message-ID: <20010927161158.E23005@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010927120353.M13535@cpe-24-221-152-185.az.sprintbbd.net> <E15mkEu-0005QS-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15mkEu-0005QS-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 12:06:44AM +0100, Alan Cox wrote:
> > > 2.4.9-ac16
> > [snip]
> > > o	Add initial pieces for EXPORT_SYMBOL_GPL	(me)
> > > 	| kernel symbols for GPL only use
> > 
> > What's the idea behind this?  Are we now going to restrict certain parts of
> > the kernel to interacting with GPL-only modules?
> 
> Imagine you have a shared library of code that makes writing some kind of
> driver easier, and you don't see why it should be available to non GPL
> driver modules. 

I can see that.  Now would there be any restrictions on this?  Ie could a
whole subsystem only export symbols for GPL-only use?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
