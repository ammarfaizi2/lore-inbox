Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTKLXfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 18:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTKLXfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 18:35:41 -0500
Received: from [66.62.77.7] ([66.62.77.7]:6091 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S261755AbTKLXfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 18:35:36 -0500
Subject: List of SCO files
From: Dax Kelson <dax@gurulabs.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1068679942.3082.131.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 12 Nov 2003 16:32:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.groklaw.net/article.php?story=2003111203544653

"I used it for comparison to file listings of different kernel versions,
and my conclusion is that this list is either based on 2.5.68 (released
April 20, 2003) or on 2.5.69 (released May 5, 2003). Those are the only
two versions that contain all of the listed files." -- Groklaw reader
"Lev"

Maybe they just did a grep for anything with the three letters SMP
(among other things).  Interesting files in the list that might support
this.

fs/reiserfs/fix_node.c

2246 : * When ported to SMP kernels, only at the last

net/ipv4/devinet.c

525- /* Note that these ioctls will not sleep,
526- so that we do not impose a lock.
527: One day we will be forced to put shlock here (I mean SMP)
528- */

net/atm/pppoatm.c

/*
* We don't really always want to do this since it's
* really inefficient - it would be much better if we could
* test if we had actually throttled the generic layer.
* Unfortunately then there would be a nasty SMP race where
* we could clear that flag just as we refuse another packet.
* For now we do the safe thing.
*/

