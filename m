Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbUK3P2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbUK3P2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbUK3P2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:28:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25761 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262111AbUK3PYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:24:12 -0500
Date: Tue, 30 Nov 2004 16:24:12 +0100
From: Martin Mares <mj@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Bernard Hatt <bernard.hatt@ntlworld.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Yet another filesystem - sffs
Message-ID: <20041130152411.GD11521@atrey.karlin.mff.cuni.cz>
References: <41AC2DBE.1080501@ntlworld.com> <20041130132310.GC4670@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130132310.GC4670@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Long time ago, Martin Mares did something very similar, IIRC it was called
> smugfs.

Actually, it was a bit smarter (but just a small bit :) ) -- it allowed
multiple files and allocated space by dividing the whole partition to
256 blocks and remembering a single-sector FAT-like structure. However,
no subdirectories were supported.

The code is probably of historical interest only, but you can find it
at ftp://atrey.karlin.mff.cuni.cz/pub/local/mj/linux/smugfs-0.0-2.0.32.tar.gz.
Once it worked, but I don't believe it's SMP safe.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"First they ignore you. Then they laugh at you. Then they fight you. Then you win." -- Gandhi
