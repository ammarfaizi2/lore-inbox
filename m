Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271063AbTHCHhY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 03:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271069AbTHCHhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 03:37:24 -0400
Received: from holomorphy.com ([66.224.33.161]:17127 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271063AbTHCHhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 03:37:21 -0400
Date: Sun, 3 Aug 2003 00:38:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3
Message-ID: <20030803073835.GL1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
References: <20030802152202.7d5a6ad1.akpm@osdl.org> <20030802223140.GA25501@outpost.ds9a.nl> <20030802164205.5cc42edc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802164205.5cc42edc.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 04:42:05PM -0700, Andrew Morton wrote:
> We already have a bucketload of highmem hacks in the kernel, and they are
> not sufficient for some people.  We have several more (large) highmem hacks
> being proposed.

Please don't put page clustering anywhere near that blacklist. There's
a lot more to it than "gee, wli shrank mem_map[] again".


On Sat, Aug 02, 2003 at 04:42:05PM -0700, Andrew Morton wrote:
> wrt long-term kernel purity: one approach would be to not merge 4G+4G into
> 2.7 at all.  This keeps the long-term kernel codebase saner.  It assumes
> that the monster 32-bit boxes will have been obsoleted by 64-bit machines
> within 3-4 years and that it is acceptable to end-of-line those machines on
> a 2.6-based kernel.  I think that's pretty safe.

Maybe some way to get feedback to/from cpu vendors about this would
help. If we really want to kill highmem dead in 2.7, beating cpu
vendors with a baseball bat until they^W^W^W^W^W^W^W^Wkindly asking
cpu vendors to kill that fucking PAE shit dead (goddammit!) might help.


-- wli
