Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTH2XR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 19:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTH2XR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 19:17:28 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:49164
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261977AbTH2XRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 19:17:25 -0400
Date: Fri, 29 Aug 2003 16:17:26 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC] extents support for EXT3
Message-ID: <20030829231726.GE3846@matchmail.com>
Mail-Followup-To: Ed Sweetman <ed.sweetman@wmich.edu>,
	Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu> <m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu> <m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu> <m3ad9snxo6.fsf@bzzz.home.net> <3F4FAFA2.4080202@wmich.edu> <20030829213940.GC3846@matchmail.com> <3F4FD2BE.1020505@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4FD2BE.1020505@wmich.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 06:25:02PM -0400, Ed Sweetman wrote:
> you get no real slowdown as far as rough benchmarks are concerned, 
> perhaps with a microbenchmark you would see one and also, doesn't it 
> take up more space to save the extent info and such? Either way, all of 
> it's real benefits occur on large files.

IIRC, if your blocks are contiguous, you can save as soon as soon as the
file size goes above one block (witout extents, the first 12 blocks are
pointed to by what?  I forget... :-/ )
