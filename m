Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSGXJox>; Wed, 24 Jul 2002 05:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSGXJow>; Wed, 24 Jul 2002 05:44:52 -0400
Received: from ns.suse.de ([213.95.15.193]:4877 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316882AbSGXJow>;
	Wed, 24 Jul 2002 05:44:52 -0400
Date: Wed, 24 Jul 2002 11:47:44 +0200
From: Dave Jones <davej@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: bcrl@redhat.com, dalecki@evision.ag, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.27 enum
Message-ID: <20020724114744.H16446@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rusty Russell <rusty@rustcorp.com.au>, bcrl@redhat.com,
	dalecki@evision.ag, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> <3D3BE421.3040800@evision.ag> <20020722160118.G6428@redhat.com> <20020723142704.B14323@suse.de> <20020724144937.3aa70f29.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020724144937.3aa70f29.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Wed, Jul 24, 2002 at 02:49:37PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 02:49:37PM +1000, Rusty Russell wrote:
 > Yes.  It particularly sucks on the "maintainerless" core code which is always
 > in flux.  This is also why I generally reject whitespace-cleanup patches,
 > and originally rejected the "doesnt" patches (I got convinced by the pedants).
 > 
 > OTOH, 90% of kernel code is copied from elsewhere, so janitorial cleanups
 > *are* worthwhile, as long as they are one-liners, or fix a real problem.

I agree in part. Take the initialiser patches you're currently carrying
for example. Whilst they're more useful (and more likely) to get merged
than the enum patches, they also have the annoying issue that anyone
currently working on code near those gets shafted.

With large touching patches like these, the only way to not piss people
off is to find out who's working on a particular area, and work with
them. "Can you roll this into your current working tree, and push to
Linus next time". Instead of just shovelling straight to Linus.
(Note, you did seem to actually seem to do the right thing here FWICS.
 have a gold star to go alongside your recent black one).

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
