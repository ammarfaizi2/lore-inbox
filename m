Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261871AbSI1VR4>; Sat, 28 Sep 2002 17:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262055AbSI1VR4>; Sat, 28 Sep 2002 17:17:56 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:57098 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261871AbSI1VR4>; Sat, 28 Sep 2002 17:17:56 -0400
Date: Sat, 28 Sep 2002 22:23:08 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Ed Tomlinson <tomlins@cam.org>, Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 kmem_cache bug
Message-ID: <20020928212308.GA61236@compsoc.man.ac.uk>
References: <20020928201308.GA59189@compsoc.man.ac.uk> <3D961797.B4094994@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D961797.B4094994@digeo.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17vP3O-000OJE-00*7SmSiTr07tQ* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 01:56:55PM -0700, Andrew Morton wrote:

> 	if (list_empty(&cachep->slabs_free))
> 		list_add(&slabp->list, &cachep->slabs_free);
> 	else
> 		kmem_slab_destroy(cachep, slabp);

This seems to work for me on a quick test.

thanks
john

-- 
"When your name is Winner, that's it. You don't need a nickname."
	- Loser Lane
