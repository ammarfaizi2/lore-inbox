Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWCIQAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWCIQAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWCIQAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:00:09 -0500
Received: from kanga.kvack.org ([66.96.29.28]:58825 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750723AbWCIQAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:00:08 -0500
Date: Thu, 9 Mar 2006 10:54:37 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Dave Jones <davej@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Message-ID: <20060309155437.GE5410@kvack.org>
References: <200603060117.16484.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org> <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org> <200603062124.42223.jesper.juhl@gmail.com> <20060306203036.GQ4595@suse.de> <9a8748490603061341l50febef9o3cb480bdbdcf925f@mail.gmail.com> <20060306215515.GE11565@redhat.com> <44104EB7.9090103@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44104EB7.9090103@mbligh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 07:50:15AM -0800, Martin J. Bligh wrote:
> Do we NOT want to have DEBUG_SLAB and DEBUG_PAGEALLOC both enabled?
> Running multiple permutations is going to get really painful on the
> systems involved. Any other requests for what gets enabled (I really
> want to just stick to one 'debug' setup if possible).

Debug kernels are incredibly slow, making hitting certain races next to 
impossible.  By all means non-DEBUG kernels should definately be getting 
tested.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
