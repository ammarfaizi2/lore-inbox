Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbTK1VSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 16:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTK1VSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 16:18:41 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:48590 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263533AbTK1VSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 16:18:38 -0500
Date: Fri, 28 Nov 2003 22:18:27 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jack Steiner <steiner@sgi.com>
Cc: Jes Sorensen <jes@wildopensource.com>, linux-kernel@vger.kernel.org
Subject: Re: hash table sizes
Message-ID: <20031128211827.GA25644@wohnheim.fh-wedel.de>
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125204814.GA19397@sgi.com> <20031125130741.108bf57c.akpm@osdl.org> <20031125211424.GA32636@sgi.com> <20031125132439.3c3254ff.akpm@osdl.org> <yq0d6bcmvfd.fsf@wildopensource.com> <20031128145255.GA26853@sgi.com> <yq08ym0mpig.fsf@wildopensource.com> <20031128193536.GA28519@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031128193536.GA28519@sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[pruned CC: list]

On Fri, 28 November 2003 13:35:36 -0600, Jack Steiner wrote:
> 
> Then I still dont understand your proposal. (I probably missed some piece
> of the discussion).
> 
> You proposed above to limit the allocation to the amount of memory on a node.

Jes didn't _limit_ the allocation to the memory on a node, he _based_
it on it, instead of total memory for all nodes.  Therefore a 1024
node NUMA machine with 2GB per node has no bigger hash tables, than a
single CPU machine with 2GB total memory, however big that may be.

Unless I didn't understand his patch, that is. :)

Jörn

-- 
"Error protection by error detection and correction."
-- from a university class
