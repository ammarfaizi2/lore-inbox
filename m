Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRBPLDR>; Fri, 16 Feb 2001 06:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbRBPLDI>; Fri, 16 Feb 2001 06:03:08 -0500
Received: from host217-32-123-111.hg.mdip.bt.net ([217.32.123.111]:51465 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129156AbRBPLCy>;
	Fri, 16 Feb 2001 06:02:54 -0500
Date: Fri, 16 Feb 2001 11:05:48 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Samuel Flory <sflory@valinux.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: mke2fs and kernel VM issues
In-Reply-To: <3A8C85B9.610D0C06@valinux.com>
Message-ID: <Pine.LNX.4.21.0102161058580.2099-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2001, Samuel Flory wrote:

>   What is believed to be the current status of the typical mke2fs
> crashes/hangs due to vm issues?  I can reliably reproduce the issue on a
> heavily modifed VA kernel based on 2.2.18.  Is there a kernel which is
> believed to be a known good kernel?  (both 2.2.x and 2.4.x)

I can mke2fs (successfully) on a 270G block device. Yes, of course, I also
get various page allocation failures while this happens but they are not
deadly, i.e. the thing (our volume manager) just retries until it works
and after a while I have a valid (and a very big) ext2 filesystem with 0
processes killed.

The kernel I use is 2.4.2-pre3. The machine has 6G RAM with the 3G given
to kernel virtual. The amount of swap is massive (2G) but it is never
used. 

Regards,
Tigran

