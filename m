Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUGTN3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUGTN3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 09:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUGTN3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 09:29:35 -0400
Received: from holomorphy.com ([207.189.100.168]:24711 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265840AbUGTN3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 09:29:33 -0400
Date: Tue, 20 Jul 2004 06:29:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kurt Garloff <garloff@suse.de>, linux-kernel@vger.kernel.org,
       Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040720132930.GB1255@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kurt Garloff <garloff@suse.de>, linux-kernel@vger.kernel.org,
	Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
	andrea@suse.de
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home> <20040714154427.14234822.akpm@osdl.org> <1089851451.15336.3962.camel@abyss.home> <20040715015431.GF3411@holomorphy.com> <20040718161338.GC12527@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040718161338.GC12527@tpkurt.garloff.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 06:54:31PM -0700, William Lee Irwin III wrote:
>> The only method the kernel now has to relocate userspace memory is IO.

On Sun, Jul 18, 2004 at 06:13:38PM +0200, Kurt Garloff wrote:
> But that could be changed. If we can swap out and modify the page
> tables (to mark the page paged out) and page in to some other
> location (and modify the pagetables again), we can as well just copy
> a page and modify the page tables.
> Any fundamental reason why that should not be possible? 

No fundamental reasons, no. Just social ones (holy penguin pee).


-- wli
