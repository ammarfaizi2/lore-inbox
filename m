Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSIRF4o>; Wed, 18 Sep 2002 01:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265346AbSIRF4o>; Wed, 18 Sep 2002 01:56:44 -0400
Received: from users.linvision.com ([62.58.92.114]:24442 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S265339AbSIRF4m>; Wed, 18 Sep 2002 01:56:42 -0400
Date: Wed, 18 Sep 2002 08:01:34 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Thomas Dodd <ted@cypress.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net
Subject: Re: Problems accessing USB Mass Storage
Message-ID: <20020918080134.A5804@bitwizard.nl>
References: <1032261937.1170.13.camel@stimpy.angelnet.internal> <20020917151816.GB2144@kroah.com> <3D876861.9000601@cypress.com> <20020917174631.GD2569@kroah.com> <20020917234302.A26741@bitwizard.nl> <3D87A6E3.5090407@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D87A6E3.5090407@cypress.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 05:04:19PM -0500, Thomas Dodd wrote:
> Rogier Wolff wrote:
> >On Tue, Sep 17, 2002 at 10:46:31AM -0700, Greg KH wrote:
> >
> >>On Tue, Sep 17, 2002 at 12:37:37PM -0500, Thomas Dodd wrote:
> >>
> >>>I get the feeling it's not a true mass storage device.
> >>
> >>Sounds like it.
> >
> >
> >Nope. Sure does sound like it's a mass storage device. And it works
> >too. 
> >
> >The kernel managed to read the partition table off it, and got
> >one valid partition: sda1. 
> 
> Accept that you cannot read data from the device. At all.
> Even dd fails. And the windows drivers work (using XP
> in vmware it think it was) correctly on this same device.

If the kernel can't read the first block, you get to see something
like: 

sda: <io error on device 8:00> 
unable to read parttion table.

and I don't know how the kernel could  come up with an "sda1" all
by itself.......

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
