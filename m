Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273936AbRIXPUM>; Mon, 24 Sep 2001 11:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273944AbRIXPUE>; Mon, 24 Sep 2001 11:20:04 -0400
Received: from co3000407-a.belrs1.nsw.optushome.com.au ([203.164.252.88]:58803
	"EHLO bozar") by vger.kernel.org with ESMTP id <S273936AbRIXPTz>;
	Mon, 24 Sep 2001 11:19:55 -0400
Date: Tue, 25 Sep 2001 01:19:35 +1000
From: Andre Pang <ozone@algorithm.com.au>
To: Wolly <wwolly@gmx.net>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: Huge disk performance degradation STILL IN 2.4.10
Mail-Followup-To: Wolly <wwolly@gmx.net>, Chris Mason <mason@suse.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200109211723.TAA00638@enigma.deepspace.net> <200109232319.BAA02449@enigma.deepspace.net> <2100580000.1001289300@tiny> <200109241505.RAA12224@enigma.deepspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109241505.RAA12224@enigma.deepspace.net>
User-Agent: Mutt/1.3.22i
Message-Id: <1001344775.069479.26256.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 05:05:13PM +0200, Wolly wrote:

> Okay, I plugged some old hd into my computer and formatted one
> half with ext2, the other half with reiserfs.  It seems to be
> definitely a reiserfs issue because I cannot trigger the
> performance loss (permament hd head positioning) with ext2.

This might sound pedantic, but is ext2 on the first half of your
hard disk and reiserfs on the second half?  If so, that could skew
your results.  Try putting the reiserfs in the first half of the
disk and see if that makes a difference.

See http://www.coker.com.au/bonnie++/zcav/ for why.


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
