Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUDJWXv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 18:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbUDJWXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 18:23:51 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:19984 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S262138AbUDJWXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 18:23:50 -0400
Date: Sun, 11 Apr 2004 00:23:47 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andries Brouwer <aebr@win.tue.nl>, fledely <fledely@bgumail.bgu.ac.il>,
       linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Accessing odd last partition sector (was: [Linux-NTFS-Dev] mkntfs
 dirty volume marking)
In-Reply-To: <20040410211301.GW31500@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.21.0404102352520.840-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> 2.4 logics around block size handling is broken; we probably could backport
> that series of patches, though.  2.6 simply sets block size to GCD(page size,
> device size), so we don't have to worry about all that crap.

That's great! 

Just one question, in the most common cases the block size ends up between
512 and 4096 bytes. Depending on how this block size used, it can have a
significant impact on performance (e.g. 512 vs 4096). Is this true or is
it used to be performance independent?

	Szaka

