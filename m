Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265166AbTGHMDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbTGHMDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:03:21 -0400
Received: from tmi.comex.ru ([217.10.33.92]:1670 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S265166AbTGHMDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:03:16 -0400
X-Comment-To: Andi Kleen
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Organization: HOME
Date: Tue, 08 Jul 2003 16:17:47 +0000
In-Reply-To: <20030708141136.18e0034f.ak@suse.de> (Andi Kleen's message of
 "Tue, 8 Jul 2003 14:11:36 +0200")
Message-ID: <877k6tuh5g.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
	<p73brw5qmxk.fsf@oldwotan.suse.de> <87of05ujfo.fsf@gw.home.net>
	<20030708134601.7992e64a.ak@suse.de> <87fzlhuif0.fsf@gw.home.net>
	<20030708141136.18e0034f.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andi Kleen (AK) writes:

 AK> On Tue, 08 Jul 2003 15:50:27 +0000
 AK> bzzz@tmi.comex.ru wrote:

 >> well, it makes sense. AFAIU, only problem with this solution is that we need
 >> very well-tuned hash function.

 AK> A small rbtree or similar would work too. Linux already has the utility code for this.
 AK> And a fast path to avoid the overhead when it isn't needed (e.g. first locker uses a 
 AK> preallocated lock node, which is cheap to queue)

hmm. interesting! thanks for review.


