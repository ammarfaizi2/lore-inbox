Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265872AbUGTNxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUGTNxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 09:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUGTNxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 09:53:14 -0400
Received: from holomorphy.com ([207.189.100.168]:32647 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265872AbUGTNxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 09:53:11 -0400
Date: Tue, 20 Jul 2004 06:53:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Kurt Garloff <garloff@suse.de>, linux-kernel@vger.kernel.org,
       Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040720135308.GE1255@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Kurt Garloff <garloff@suse.de>,
	linux-kernel@vger.kernel.org, Peter Zaitsev <peter@mysql.com>,
	Andrew Morton <akpm@osdl.org>
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home> <20040714154427.14234822.akpm@osdl.org> <1089851451.15336.3962.camel@abyss.home> <20040715015431.GF3411@holomorphy.com> <20040718161338.GC12527@tpkurt.garloff.de> <20040720132916.GA3969@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720132916.GA3969@x30.random>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2004 at 06:13:38PM +0200, Kurt Garloff wrote:
>> Any fundamental reason why that should not be possible? 

On Tue, Jul 20, 2004 at 09:29:16AM -0400, Andrea Arcangeli wrote:
> of course not, though copying mbytes of data around is expensive, and
> relocation is a low priority compared to allocating ram in the right
> place with heavy imbalances.

The bias is good to have also; when it's possible correctly place
things in advance I like to see that happen. Gracefully recovering
if/when that doesn't work out is all I'd like to have beyond that.


-- wli
