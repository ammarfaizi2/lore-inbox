Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTFXIAf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 04:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTFXIAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 04:00:34 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:34574 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264226AbTFXIAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 04:00:33 -0400
Date: Tue, 24 Jun 2003 10:14:40 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Frank Cusack <fcusack@fcusack.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Luis Miguel Garcia <ktech@wanadoo.es>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel & BIOS return differing head/sector geometries
Message-ID: <20030624101440.A1412@pclin040.win.tue.nl>
References: <20030624010906.08ad32f3.ktech@wanadoo.es> <20030624013908.B1133@pclin040.win.tue.nl> <20030623173124.A2025@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030623173124.A2025@google.com>; from fcusack@fcusack.com on Mon, Jun 23, 2003 at 05:31:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 05:31:24PM -0700, Frank Cusack wrote:
> On Tue, Jun 24, 2003 at 01:39:08AM +0200, Andries Brouwer wrote:
> > Linux does not use the BIOS, and does not use CHS either, so geometry is
> > totally and completely irrelevant to Linux.
> 
> Is that also true for 2.2?

Yes.

> I've had problems where large drives (60+G)
> do these geometry tricks, and if I don't force the geometry to what I
> want, fdisk (actually, sfdisk, dunno about fdisk) doesn't see the
> entire drive.

Most likely you are talking about a disk soft-clipped by jumper.
Some BIOSes cannot handle disks larger than 32GB, so all larger
disks come with a jumper that makes the disk look like a 32GB disk.
The details depend on the disk manufacturer.
A lot of details can be found in
http://www.win.tue.nl/~aeb/linux/Large-Disk-11.html#ss11.3

