Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262122AbSIYUcL>; Wed, 25 Sep 2002 16:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262125AbSIYUcL>; Wed, 25 Sep 2002 16:32:11 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:4483 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262122AbSIYUcK>;
	Wed, 25 Sep 2002 16:32:10 -0400
Date: Wed, 25 Sep 2002 21:41:01 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: tytso@mit.edu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020925204101.GA5420@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, tytso@mit.edu,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17uINs-0003bG-00@think.thunk.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 04:03:44PM -0400, tytso@mit.edu wrote:

 > This patch significantly increases the speed of using large directories.
 > Creating 100,000 files in a single directory took 38 minutes without
 > directory indexing... and 11 seconds with the directory indexing turned on.

Just curious.. what measurable overhead (if any) is there of indexing
dirs with smaller numbers of files vs non-indexed ?
If so, where would be the break-even point ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
