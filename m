Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLGUOX>; Thu, 7 Dec 2000 15:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130877AbQLGUON>; Thu, 7 Dec 2000 15:14:13 -0500
Received: from hera.cwi.nl ([192.16.191.1]:30661 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129458AbQLGUN5>;
	Thu, 7 Dec 2000 15:13:57 -0500
Date: Thu, 7 Dec 2000 20:43:29 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Stephen Williams <steve@icarus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 40Gig IDE disk wrapping around at 32Gig?
Message-ID: <20001207204329.A24051@veritas.com>
In-Reply-To: <200012071722.JAA07401@icarus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200012071722.JAA07401@icarus.com>; from steve@icarus.com on Thu, Dec 07, 2000 at 09:22:38AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 09:22:38AM -0800, Stephen Williams wrote:

> During an install of RedHat 6.1 onto a Dell Dimension L600cx, I partitioned
> the internal 40gig disk to include 4 partitions. I initially let the disk
> druid do it, but it rendered the partition table unreadable. So I used
> fdisk and partitioned it with primary partitions like so:
...
> Problem is, any attempt to mkfs on /dev/hda4 seems to trash the filesystems
> on hda1, hda2 and hda3. It makes an ugly mess.
> 
> RedHat 6.1 installs a 2.2.12 kernel

Large disks require 2.2.14 / 2.3.21 or later.

> with patches.

For vendor patches, consult the vendor.

(And, in case you have more problems: include (i) fdisk version.
(ii) kernel version, (iii) dmesg | grep hd.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
