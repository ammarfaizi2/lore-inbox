Return-Path: <linux-kernel-owner+w=401wt.eu-S1161247AbXAHMDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbXAHMDh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 07:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbXAHMDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 07:03:37 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:36368 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161247AbXAHMDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 07:03:36 -0500
Date: Mon, 8 Jan 2007 13:03:32 +0100 (MET)
From: Jonas Svensson <jonass@lysator.liu.se>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: trouble loading self compiled vanilla kernel
In-Reply-To: <45A228CC.5020004@imap.cc>
Message-ID: <Pine.GSO.4.51L2.0701081301520.27141@nema.lysator.liu.se>
References: <Pine.GSO.4.51L2.0701081054010.27141@nema.lysator.liu.se>
 <45A228CC.5020004@imap.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007, Tilman Schmidt wrote:

> Jonas Svensson schrieb:
> > I downloaded kernel 2.6.19.1 from kernel.org and compiled it like
> > make mrproper, make menuconfig, make, make modules_install, make install.
> [...]
> > All results in the same problem: the booting stops about when grub is
> > finished and the kernel should continue. I get the
> > message about loading initrd but not the line of "Uncompressing
> > Linux... Ok, booting the kernel". Instead I get a blank screen with a
> > flashing cursor at top left. Thats all, nothing more happens. Any
> > suggestions on what could be wrong or what I should do?
>
> Did you build a new initrd to go with your new kernel?

I beleive make install does that in CentOS. There were a new initrd
installed and it was not identical to the one supplied by CentOS.
