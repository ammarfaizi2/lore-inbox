Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264816AbRFXWCb>; Sun, 24 Jun 2001 18:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264828AbRFXWCR>; Sun, 24 Jun 2001 18:02:17 -0400
Received: from media.umbc.edu ([130.85.179.78]:50627 "EHLO media.umbc.edu")
	by vger.kernel.org with ESMTP id <S264815AbRFXWBZ>;
	Sun, 24 Jun 2001 18:01:25 -0400
From: Ray Shaw <ray@media.umbc.edu>
Date: Sun, 24 Jun 2001 18:01:10 -0400
To: linux-kernel@vger.kernel.org
Subject: NFS server difficulties
Message-ID: <20010624180110.A18452@media.umbc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I thought I saw a post regarding a similar problem to mine, and
mentioning a patch, but I can't find the post anymore (and I never
found the patch), so:

I'm currently running 2.4.5-ac9.  Earlier 2.4.x kernels worked OK with
NFS, but blew up on my Athlon machine.  This kernel does _not_ work OK
with NFS.  I can mount shared directories on either of my roommate's
machines with no problems.  They can mount my shares, and perhaps do
an ls or two, but any operations beyond that will hang (at their end;
all my logs show nothing, and my machine is unaffected) until NFS
times out.

I've tried both the user and the kernel nfs server.  My roommate has
tried 2.4.5-ac7, 2.4.5-ac15, and 2.2.19, none of which worked.  My
other roommate has a machine running a 2.4pre kernel which _does_
work, and also a 2.4.1 kernel which I believe works.  We have another
machine running 2.4.3 with the XFS patch; that one doesn't work.

I have a tulip NIC and am using ext2, if that helps.  Another
interesting thing is that I'm also running Samba, and both smbfs (on
their end) and my Windows machine experience problems almost identical
to NFS.  So it really might be the NIC.

I'm not subscribed, but I read the newsgroup via Google, so there's no
pressing need to Cc me on replies.

Any help is greatly appreciated.


-- 
--Ray

-----------------------------
Sotto la panca la capra crepa
sopra la panca la capra campa
