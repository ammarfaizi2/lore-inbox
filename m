Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268964AbTBWWBW>; Sun, 23 Feb 2003 17:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268982AbTBWWBW>; Sun, 23 Feb 2003 17:01:22 -0500
Received: from holomorphy.com ([66.224.33.161]:60589 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268964AbTBWWBV>;
	Sun, 23 Feb 2003 17:01:21 -0500
Date: Sun, 23 Feb 2003 14:10:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: pte-highmem vs UKVA (was: object-based rmap and pte-highmem)
Message-ID: <20030223221030.GK10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302231335090.1534-100000@home.transmeta.com> <22420000.1046038049@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22420000.1046038049@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 02:07:42PM -0800, Martin J. Bligh wrote:
> Using UKVA for PTEs seems to be a better way to implement pte-highmem to me.
> If you're walking another processes' pagetables, you just kmap them as now,
> but I think this will avoid most of the kmap'ing (if we have space for two
> sets of pagetables so we can do a little bit of trickery at fork time).

Another term for "UKVA for pagetables only" is "recursive pagetables",
if this helps clarify anything.


-- wli
