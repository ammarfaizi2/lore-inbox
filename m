Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbTL3MON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 07:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265786AbTL3MON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 07:14:13 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:61372 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265785AbTL3MOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 07:14:11 -0500
Date: Tue, 30 Dec 2003 04:14:03 -0800
From: Paul Jackson <pj@sgi.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, wim@iguana.be, akpm@osdl.org,
       linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches
Message-Id: <20031230041403.3ec6f2e4.pj@sgi.com>
In-Reply-To: <3FF0903F.1030604@pobox.com>
References: <20030906125136.A9266@infomag.infomag.iguana.be>
	<20031229205246.A32604@infomag.infomag.iguana.be>
	<Pine.LNX.4.58.0312291209150.2113@home.osdl.org>
	<3FF0903F.1030604@pobox.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another possibility I like is to recreate my changes (what few so far
...) against a clean bk tree, before sending.  Hide all my internal
iterations and changes from others.

I will pull frequently and liberally into the bk clones that I use to
track 2.6, 2.6-mm and whatever else I am based on.  These in turn I pull
into my main working bk tree, along with pulling in the various changes
I have in progress, each from their own bk clone.

Then when it comes time to send out a patch, I:

  1) Generate an old fashioned patch (bk export -tpatch),
     containing just the revisions relevant to what I will send.
  2) Clone a fresh bk tree that is closest to whatever
     the recipient of my patch would like to work with
  3) Apply the patch to the fresh clone, generating a
     clean history of one change for just that patch.
  4) Double check that that builds and boots.
  5) Then send that change out, usually by exporting it as a
     -second- old fashioned patch, since for reasons not
     relevant here, I end up sending patches, not bk pulls,
     down stream.

The objective being:

  My final "published work" is that patch - it should be
  as clean as practical.

By going into and back out of old fashioned patches, I isolate
the anal history that bk kept of all my interim changes from
the rest of the world.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
