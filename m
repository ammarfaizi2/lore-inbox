Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbTK3MtV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 07:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTK3MtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 07:49:21 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:49425 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264896AbTK3MtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 07:49:19 -0500
Date: Sun, 30 Nov 2003 13:49:16 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: "Andrew Clausen" <clausen@gnu.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031130124916.GA5738@win.tue.nl>
References: <13d401c3b710$d6c17bf0$11ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d401c3b710$d6c17bf0$11ee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 04:08:22PM +0900, Norman Diamond wrote:
> Andries Brouwer replied to Andrew Clausen:
> 
> > I am happy with that description.
> > "Disk geometry is: some numbers that your BIOS invents".
> 
> I'm happy with that too.  Now, since the Linux kernel has no fantasies about
> disk geometry, it is fine to refuse to provide such non-existent fantasies
> to user space.  However, it remains necessary to provide the BIOS's
> fantasies to user space.  Sometimes user space does something (via the
> kernel) that will later be interpreted by the BIOS.  User space has to be
> able to do it in the manner that the BIOS wants.

The point is just that the Linux kernel has no idea about these BIOS fantasies.
It may have a more or less elaborate system of guesses, but it has no
knowledge. In practice things work better if the kernel never tries to
tell anything to user space, and user space derives the desired BIOS fantasies
from the partition table.

> Anyway, regardless of which OS you're running, the OS isn't running until
> it's running.  The MBR depends on BIOS functions (e.g. the infamous INT13)
> to read in the boot loader and the boot loader depends on BIOS functions to
> read in the kernel.  Yes Dr. Brouwer, I know you know this.  The question is
> why you think that commands such as parted don't have to know this?

You invent a title for me that I never used.
You invent an opinion for me that I never had.


