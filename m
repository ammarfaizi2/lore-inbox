Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTINLSU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 07:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTINLSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 07:18:20 -0400
Received: from tench.street-vision.com ([212.18.235.100]:38808 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S262369AbTINLSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 07:18:16 -0400
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
From: Justin Cormack <justin@street-vision.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030913212723.GA21426@gtf.org>
References: <1063484193.1781.48.camel@mulgrave> 
	<20030913212723.GA21426@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 14 Sep 2003 12:15:27 +0100
Message-Id: <1063538182.1510.78.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-13 at 22:27, Jeff Garzik wrote:

> IMO, we need to move users from a [probe-]order-based device and bus
> enumeration to some system based on unique ids.  I'm of the opinion
> that _both_ block devices and filesystems need some sort of GUID.
> Luckily, a lot of blkdevs/fs's are already there.
> 
> If you look at current usage out there, order isn't _terribly_ important
> given today's tools (such as LABEL=).  More important IMO is figuring
> out which spindle is your boot disk, and which is your root disk.
> Red Hat handles root disks by doing LABEL= from initrd.  But discovering
> the boot disk is still largely an unsolved problem AFAIK...

LABEL= is so broken that I immediately remove it from all my redhat
systems. It is not unique at all. As soon as you plug another system
disk into your system at boot time all hell breaks loose. At least it
could have a random number in it or something.

If you need to know your bootdisk (why?) why not just get the bootloader
to tell you?

Justin


