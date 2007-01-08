Return-Path: <linux-kernel-owner+w=401wt.eu-S1161322AbXAHPxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161322AbXAHPxG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161320AbXAHPxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:53:05 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:39009 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161322AbXAHPxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:53:04 -0500
Date: Mon, 8 Jan 2007 16:52:59 +0100 (MET)
From: Jonas Svensson <jonass@lysator.liu.se>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: trouble loading self compiled vanilla kernel
In-Reply-To: <45A2611A.7040900@imap.cc>
Message-ID: <Pine.GSO.4.51L2.0701081644110.27141@nema.lysator.liu.se>
References: <Pine.GSO.4.51L2.0701081054010.27141@nema.lysator.liu.se>
 <45A228CC.5020004@imap.cc> <Pine.GSO.4.51L2.0701081301520.27141@nema.lysator.liu.se>
 <45A2611A.7040900@imap.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007, Tilman Schmidt wrote:

> Jonas Svensson schrieb:
> > On Mon, 8 Jan 2007, Tilman Schmidt wrote:
> >
> >> Jonas Svensson schrieb:
> >> [...]
> >> > All results in the same problem: the booting stops about when grub is
> >> > finished and the kernel should continue. I get the
> >> > message about loading initrd but not the line of "Uncompressing
> >> > Linux... Ok, booting the kernel". Instead I get a blank screen with a
> >> > flashing cursor at top left. Thats all, nothing more happens. Any
> >> > suggestions on what could be wrong or what I should do?
> >>
> >> Did you build a new initrd to go with your new kernel?
> >
> > I beleive make install does that in CentOS. There were a new initrd
> > installed and it was not identical to the one supplied by CentOS.
>
> That's surprising. On SuSE I always have to build it separately
> with mkinitrd, and the kernel makefiles are the same, after all.
> Anyway, your symptoms definitely look like a bad initrd, so you
> may want to have a closer look in that area. Perhaps build a
> kernel you can boot without initrd for testing, ie. with the
> drivers for the root disk and filesystem built in.

I have done a kernel without support for modules and what I beleive is
sane settings regarding drivers. I installed it and removed the initrd
from grub.config but still got the same error.

I will try it again, maybe I missed something. I will also try to read
more on initrd and see if I am wrong to assume that make install does it
for me.

Thanks for trying to help.

