Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262852AbTCKHhq>; Tue, 11 Mar 2003 02:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262853AbTCKHhq>; Tue, 11 Mar 2003 02:37:46 -0500
Received: from holomorphy.com ([66.224.33.161]:49848 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262852AbTCKHhp>;
	Tue, 11 Mar 2003 02:37:45 -0500
Date: Mon, 10 Mar 2003 23:47:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dcache hash distrubition patches
Message-ID: <20030311074712.GG20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@muc.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <10280000.1047318333@[10.10.2.4]> <20030310175221.GA20060@averell> <26350000.1047368465@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26350000.1047368465@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 11:41:07PM -0800, Martin J. Bligh wrote:
> It's not perfect, but not bad either. Some mathematician can go calculate
> just how imperfect it is over random distribution, but it looks OK to me ;-)

Okay, the standards are a bit more stringent for hash functions. You
basically want the total number of collisions to be minimized.

That said, standard statistical things are useful for first-pass
discrimination.

This looks basically okay, but if it's really just even with respect
to cache pressure the need for a different data structure in the
eventual future is clear. I'd need a baseline (pre-hlist) dcache
snapshot to compare against to get a better idea.


-- wli
