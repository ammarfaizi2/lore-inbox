Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273304AbRIWHOB>; Sun, 23 Sep 2001 03:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273305AbRIWHNm>; Sun, 23 Sep 2001 03:13:42 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:51045 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S273304AbRIWHNY>;
	Sun, 23 Sep 2001 03:13:24 -0400
Message-ID: <20010923091408.A850@win.tue.nl>
Date: Sun, 23 Sep 2001 09:14:08 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Luben Karavelov <luben@bgone.net>, linux-kernel@vger.kernel.org
Subject: Re: kernel can not scan partition table of hdd?
In-Reply-To: <20010923021623.A1201@bgone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010923021623.A1201@bgone.net>; from Luben Karavelov on Sun, Sep 23, 2001 at 02:16:23AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 02:16:23AM +0300, Luben Karavelov wrote:

> If the partition table of the disk is not correct,
> how to fix it?

Your partition table looks fine, nothing wrong with that.

But the partition table is the very first thing the kernel
tries to read from disk, so probably disk reading fails.

> I have the following problem. After I have upgraded the 
> kernel from from 2.4.7 to 2.4.9 I have found that the new
> kernel can not scan the partition table of the disk - it
> freezes for a moment and than i continue but it cannot
> find the root device after that.
> The situation with 2.4.10-pre14 and 2.4.9-ac14 is the same.
> The chipset of the ide controller is VIA82C59x. The disk is
> Quantum Fireball tm1280a ATA.
