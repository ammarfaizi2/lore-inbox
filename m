Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbQKNB26>; Mon, 13 Nov 2000 20:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129434AbQKNB2s>; Mon, 13 Nov 2000 20:28:48 -0500
Received: from hera.cwi.nl ([192.16.191.1]:23494 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129227AbQKNB2g>;
	Mon, 13 Nov 2000 20:28:36 -0500
Date: Tue, 14 Nov 2000 01:58:34 +0100
From: Andries Brouwer <aeb@veritas.com>
To: LA Walsh <law@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: IDE0 /dev/hda performance hit in 2217 on my HW - more info - maybe extended partitions
Message-ID: <20001114015834.A24158@veritas.com>
In-Reply-To: <00111322024100.20267@dax.joh.cam.ac.uk> <NBBBJGOOMDFADJDGDCPHCEJECJAA.law@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <NBBBJGOOMDFADJDGDCPHCEJECJAA.law@sgi.com>; from law@sgi.com on Mon, Nov 13, 2000 at 03:47:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2000 at 03:47:27PM -0800, LA Walsh wrote:

> Some further information in response to a private email, I did hdparm -ti
> under both
> 2216 and 2217 -- they are identical -- this may be something weird
> w/extended partitions...

What nonsense. There is nothing special with extended partitions.
Partitions influence the logical view on the disk, but not I/O.

(But the outer rim of a disk is faster than the inner side.)

Moreover, you report elapsed times
0:27, 0:22, 0:24, 0:28, 0:21, 0:24, 0:27
where is this performance hit?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
