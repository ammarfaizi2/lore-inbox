Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265832AbUAPWLX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265836AbUAPWIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:08:17 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:16880 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265794AbUAPV52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:57:28 -0500
Date: Fri, 16 Jan 2004 13:57:23 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ian Pilcher <i.pilcher@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA] - run-length compaction of block numbers
Message-ID: <20040116215723.GR1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Ian Pilcher <i.pilcher@comcast.net>,
	linux-kernel@vger.kernel.org
References: <BAY1-F117hxeH6PC8MS00006f92@hotmail.com> <200401161954.i0GJsEgj003906@turing-police.cc.vt.edu> <40084B33.60209@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40084B33.60209@comcast.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 02:36:03PM -0600, Ian Pilcher wrote:
> Valdis.Kletnieks@vt.edu wrote:
> >
> >On the other hand, dynamic allocation of inodes is interesting, as it means
> >you're not screwed if over time, the NBPI value for the filesystem changes 
> >(or
> >if you simply guessed wrong at mkfs time) and you run out of inodes when 
> >you
> >still have space free.  Reiserfs V3 already does this, in fact...
> >
> 
> As does JFS.  Anyone know about XFS?

Yes, XFS has dynamic inodes also.
