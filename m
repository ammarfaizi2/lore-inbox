Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUDAVp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbUDAVov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:44:51 -0500
Received: from ns.suse.de ([195.135.220.2]:16322 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263273AbUDAVm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:42:59 -0500
Date: Thu, 1 Apr 2004 23:40:31 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Martin Schaffner <schaffner@gmx.li>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: booting 2.6.4 from OpenFirmware
Message-ID: <20040401214031.GA22366@suse.de>
References: <321B041D-8298-11D8-AC61-0003931E0B62@gmx.li> <1080687527.1198.48.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1080687527.1198.48.camel@gaston>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Mar 31, Benjamin Herrenschmidt wrote:

> On Wed, 2004-03-31 at 08:18, Martin Schaffner wrote:
> > Hi,
> > 
> > I try to boot linux-2.6.4 from OpenFirmware on my Apple iBook2 (dual 
> > USB). I'm using the image named "vmlinux.elf-pmac". While linux-2.4.25 
> > boots fine, linux-2.6.4 doesn't without the following modifications:
> > 
> > http://membres.lycos.fr/schaffner/howto/linux26-boot-of.txt
> > 
> > (I found this procedure by trial and error, by mixing stuff from 2.4 
> > into the build of 2.6.)
> > 
> > If I try to boot the stock kernel, OpenFirmware tells me "Claim 
> > failed", and returns to the command prompt.
> > 
> > Does anybody have an idea what is the cause of this?
> 
> That's strange, I do such netbooting everyday on a wide range of
> machines without trouble. Are you using some kind of cross compiler ?
> Maybe there are some issues with cross compiling of the boot wrapper...

This is fixed.  your options:
update to 2.6.5-rc3
disable modversions

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
