Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266552AbUGKK1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266552AbUGKK1r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266553AbUGKK1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:27:47 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:36323 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266552AbUGKK1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:27:44 -0400
Date: Sun, 11 Jul 2004 12:27:43 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: albertogli@telpin.com.ar, linux-kernel@vger.kernel.org
Subject: Re: Syncing a file's metadata in a portable way
Message-ID: <20040711102743.GB16199@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@osdl.org>, albertogli@telpin.com.ar,
	linux-kernel@vger.kernel.org
References: <20040709030637.GB5858@telpin.com.ar> <20040709023948.59497dca.akpm@osdl.org> <20040710115404.GA11420@outpost.ds9a.nl> <20040710131459.13ffec23.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710131459.13ffec23.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 01:14:59PM -0700, Andrew Morton wrote:

> If only the one file has been written to, an fsync on ext3 shouldn't
> produce any more writeout than an fsync on ext2.
(...)
> Either that, or SQLite is broken.

I'll show strace and vmstat tomorrow - I found very little writes, no mmap,
some fsync and massive writeouts. On ext2, performance was two orders of
magnitude better.

	Bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
