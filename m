Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQL2BP3>; Thu, 28 Dec 2000 20:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbQL2BPT>; Thu, 28 Dec 2000 20:15:19 -0500
Received: from ANancy-101-1-1-133.abo.wanadoo.fr ([193.251.70.133]:12530 "HELO
	the-babel-tower.nobis.phear.org") by vger.kernel.org with SMTP
	id <S129465AbQL2BPM>; Thu, 28 Dec 2000 20:15:12 -0500
Message-ID: <20001229024906.10670.qmail@the-babel-tower.nobis.phear.org>
From: Pixel@nobis.phear.org
Subject: Re: New driver
To: linux-kernel@vger.kernel.org
Date: Fri, 29 Dec 2000 03:49:06 +0100 (CET)
In-Reply-To: <13378.978040423@ocs3.ocs-net> from "Keith Owens" at Dec 29, 2000 08:53:43 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, 28 Dec 2000 22:19:37 +0100 (CET), 
> Pixel@the-truth.nobis.phear.org wrote:
> >I wanted to share what I've done but since I'm very new to kernel hacking
> >I don't know what to do with my patch. Could you give me some hints?
> 
> linux/Documentation/SubmittingPatches
> 

Ok. Since it's a new category, there's no maintainers for it. I'll post the patch here. 

And since it's quite a bit patch (about 120Kb) you can download the plain text patch at
this URL: http://www.ifrance.com/nobis/em8300-patch.

This patch is against the linux-2.4.0-test13-pre5 source tree.

Description: this is the integration of the em8300 driver available at
 http://dxr3.sourceforge.net

The primary driver is only an external source driver. So I decided to try to build it
directly into the kernel source tree (there was incompatibilities with the new
Makefile system) and to add a devfs support for the devices. As it is a new category,
I've added a submenu to the configuration system: MPEG cards into the Multimedia
section. Please note I didn't wrote this driver but simply integrated an existing
driver.

  -- Nicolas Noble

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
