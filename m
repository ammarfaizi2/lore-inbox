Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUGMAMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUGMAMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUGMAKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:10:34 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:43707 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264461AbUGMAKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:10:22 -0400
Date: Mon, 12 Jul 2004 17:10:20 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Alex Weiss <aweiss@fscv.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gentoo kernel possible bug when trying to emerge k3b.
Message-ID: <20040713001020.GA25050@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0407121922060.23245@chimpanzee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407121922060.23245@chimpanzee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 07:23:22PM -0400, Alex Weiss wrote:

> ide0: reset: success
> hda: task_in_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_in_intr: error=0x10 { SectorIdNotFound }, LBAsect=78135524, 
> sector=78135524

disk (hardware) error, either seeking to a sector that's not their
(it's at ~38GB, how large is the device) or the disk is going bad

> Linux chimpanzee 2.6.7-gentoo-r10 #1 Mon Jul 12 18:16:54 EDT 2004 i686 
> Intel(R) Pentium(R) 4 CPU 2.60GHz GenuineIntel GNU/Linux

afaik gentoo has a bug db to bitch into (in general lkml isn't useful
for vendor kernels)



  --cw
