Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267455AbUH2Jfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267455AbUH2Jfq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 05:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267461AbUH2Jfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 05:35:46 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:26849 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S267455AbUH2Jfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 05:35:41 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16689.41835.805352.462598@thebsh.namesys.com>
Date: Sun, 29 Aug 2004 13:35:39 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com, Alexander Zarochentcev <zam@namesys.com>
Subject: Re: reiser4 plugins
In-Reply-To: <41311907.7010605@namesys.com>
References: <20040825152805.45a1ce64.akpm@osdl.org>
	<412D9FE6.9050307@namesys.com>
	<20040826014542.4bfe7cc3.akpm@osdl.org>
	<1093522729.9004.40.camel@leto.cs.pocnet.net>
	<20040826124929.GA542@lst.de>
	<1093525234.9004.55.camel@leto.cs.pocnet.net>
	<20040826130718.GB820@lst.de>
	<1093526273.11694.8.camel@leto.cs.pocnet.net>
	<20040826132439.GA1188@lst.de>
	<1093527307.11694.23.camel@leto.cs.pocnet.net>
	<20040826134034.GA1470@lst.de>
	<1093528683.11694.36.camel@leto.cs.pocnet.net>
	<412E786E.5080608@namesys.com>
	<16687.9051.311225.697109@thebsh.namesys.com>
	<412F7A59.8060508@namesys.com>
	<16687.33718.571411.76990@thebsh.namesys.com>
	<41305619.9030401@namesys.com>
	<16688.36091.861155.985990@gargle.gargle.HOWL>
	<41311907.7010605@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:

[...]

 > 
 > I remember talking with not just you but zam about how we could fix it, 
 > and there was too much in the queue of work, and everyone was 
 > complaining to me that we should be debugging not optimizing, and you 
 > were the only one who thought it was a big deal.  I guess you still 

You are trying to evade the point. And the point is not how performance
in these phases (and their impact on other phases) can be improved, or
what excuses did you have for not `doing' it, but the fact that after it
was found that large keys behave badly, these phases were turned off,
others were switched to lexicographical operation, _and_ resulting
benchmark is used as a basis to call other people names.

 > think it is a big issue and I still think things are good enough to use 
 > without it.  I still think Zam understood the issues better than you did 
 > (allocation is his code not yours).
 > 
 > There are some layout optimizations that a repacker can do best.  Still, 
 > there are some rough spots in the current allocation policy, and we 
 > should look at it.
 > 
 > Probably you will have reason to howl if we setup a benchmark which 

Surely, as a `big dog' what other sounds can I produce? :)

 > disturbs things with these phases, runs the repacker (I hope to have one 
 > in 6 months), and then measures our read performance compared to other 
 > filesystems without a repacker....;-)

That's ok with me, but it would make sense to remove unfair benchmarks
from the site until then.

 > 
 > Hans

Nikita.
