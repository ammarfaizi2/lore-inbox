Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUGTNeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUGTNeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 09:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUGTNeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 09:34:06 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25475
	"EHLO x30.random") by vger.kernel.org with ESMTP id S265833AbUGTNeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 09:34:05 -0400
Date: Tue, 20 Jul 2004 09:29:16 -0400
From: Andrea Arcangeli <andrea@suse.de>
To: Kurt Garloff <garloff@suse.de>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>,
       Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040720132916.GA3969@x30.random>
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home> <20040714154427.14234822.akpm@osdl.org> <1089851451.15336.3962.camel@abyss.home> <20040715015431.GF3411@holomorphy.com> <20040718161338.GC12527@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040718161338.GC12527@tpkurt.garloff.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2004 at 06:13:38PM +0200, Kurt Garloff wrote:
> Any fundamental reason why that should not be possible? 

of course not, though copying mbytes of data around is expensive, and
relocation is a low priority compared to allocating ram in the right
place with heavy imbalances.
