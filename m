Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263513AbUJ3Eo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUJ3Eo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 00:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263512AbUJ3Eo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 00:44:27 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:56593 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263513AbUJ3EoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 00:44:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EvOI21o+dXgyY4IMRyq95W0I/ibWmzpb+ynDna2wTn1zWvWCvmSfJ9bBPm8ARnyzGA9YAvMA/6ynacBxhY14408qi1SeiaGAxSSnrnh8Z2dWoGYkN6cTAoZLEvhWkjDmM22KSHbKERQfsOXGe1nPa2YpYGNn+NQWvniNt0dkCuw=
Message-ID: <29495f1d04102921447ab65101@mail.gmail.com>
Date: Fri, 29 Oct 2004 21:44:18 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [KJ] 2.6.10-rc1-kjt1: ixgb_ethtool.c doesn't compile
Cc: kj <kernel-janitors@osdl.org>, linux-kernel@vger.kernel.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <20041029235137.GG6677@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041024151241.GA1920@stro.at> <20041029235137.GG6677@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 01:51:37 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Oct 24, 2004 at 05:12:41PM +0200, maximilian attems wrote:
> >...
> > splitted out 168 patches:
> > http://debian.stro.at/kjt/2.6.10-rc1-kjt1/split/
> 
> Could you provide a .tar.gz (or .tar.bz) of the splitted patches
> (similar to how Andrew does for -mm)?

Do you mean like the one he provided?

please test out:
http://debian.stro.at/kjt/2.6.10-rc1-kjt1/2.6.10-rc1-kjt1.patch.bz2

Admittedly, it's not tarred first, but still... Maybe you mean
something else, though, and I'm just confused.

> > thanks for feedback.
> > maks
> >...
> 
> msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch doesn't
> compile:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/net/ixgb/ixgb_ethtool.o
> drivers/net/ixgb/ixgb_ethtool.c: In function `ixgb_ethtool_led_blink':
> drivers/net/ixgb/ixgb_ethtool.c:407: error: `id' undeclared (first use in this function)
> drivers/net/ixgb/ixgb_ethtool.c:407: error: (Each undeclared identifier is reported only once
> drivers/net/ixgb/ixgb_ethtool.c:407: error: for each function it appears in.)
> make[3]: *** [drivers/net/ixgb/ixgb_ethtool.o] Error 1

Thanks for catching this, I will make the change to the patch tomorrow
and send it again.

-Nish
