Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSFXRFJ>; Mon, 24 Jun 2002 13:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314475AbSFXRFI>; Mon, 24 Jun 2002 13:05:08 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:3799 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S314451AbSFXRFH>; Mon, 24 Jun 2002 13:05:07 -0400
Date: Mon, 24 Jun 2002 13:05:07 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Frank Davis <fdavis@si.rr.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 : drivers/scsi/dpt_i2o.c for PCI DMA
In-Reply-To: <Pine.LNX.4.44.0206232353390.909-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.33.0206241257450.10816-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2002, Frank Davis wrote:
>Hello all,
>  Here's another 1st step patch for DMA usage for the dpt_i2o driver.
>Please review.

There *are* 64bit boards controlled by the dpt_i2o driver.  So, blindly
setting the DMA mask for 32bit is not, entirely, correct.

--Ricky


