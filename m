Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSHaQJN>; Sat, 31 Aug 2002 12:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSHaQJN>; Sat, 31 Aug 2002 12:09:13 -0400
Received: from ns.suse.de ([213.95.15.193]:38150 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316542AbSHaQJM>;
	Sat, 31 Aug 2002 12:09:12 -0400
Date: Sat, 31 Aug 2002 18:13:38 +0200
From: Dave Jones <davej@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Jani Monoses <jani@iv.ro>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.32 : u.ext3_sb -> generic_sbp
Message-ID: <20020831181338.A28204@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andrew Morton <akpm@zip.com.au>, Jani Monoses <jani@iv.ro>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.21.0001010429580.1200-100000@localhost.localdomain> <3D6FC178.CC3E89CD@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D6FC178.CC3E89CD@zip.com.au>; from akpm@zip.com.au on Fri, Aug 30, 2002 at 12:03:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 12:03:20PM -0700, Andrew Morton wrote:
 > > This turns the remaining parts of ext3 to EXT3_SB and turns the latter
 > > from a macro to inline function which returns the generic_sbp field of u.
 > Thanks.
 > It's not going to make the merge of all Stephen's 2.4 changes
 > any more fun though ;)

The last 2.5-dj I did should be in sync as of ext3 in 2.4.19,
but lacks the bits sct came up with recently for 2.4.20pre.[1]
(Also 1-2 other janitor type things there too, I'll push some
fs stuff to various people soon).

        Dave

[1] For the curious, I'm not syncing 2.4.20pre's, I'll wait until
    .20 final, and do a big resync for 2.5.x-dj.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
