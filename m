Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVIKSzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVIKSzV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVIKSzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:55:21 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:54162 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S965041AbVIKSzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:55:20 -0400
Date: Sun, 11 Sep 2005 20:57:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: What's up with the GIT archive on www.kernel.org?
Message-ID: <20050911185711.GA22556@mars.ravnborg.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Absolutely. The mirroring has been slow again lately. I've packed my 
> archive, but I suspect others should much more aggressively now be using 
> the "objects/info/alternates" information to point to my tree, so that 
> they don't even need to have their objects at all (no packing 
> even necessary - just running "git prune-packed" on peoples archives 
> would get rid of any duplicate objects when I pack mine).

Can you post a small description how to utilize this method?


What I've done lately has been to cp -al your .git archive.
This works well when I get everything merged up and has been my lazy
method to avoid doing merges yet (being cogito user I do not trust merge
atm. because I have mixed up older cogito with newest git).

	Sam
