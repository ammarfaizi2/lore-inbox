Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbUELXfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUELXfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 19:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUELXfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 19:35:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:41926 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263231AbUELXfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 19:35:09 -0400
Date: Wed, 12 May 2004 16:34:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Yang, Chen" <chyang@clusterfs.com>
cc: Muli Ben-Yehuda <mulix@mulix.org>, Anton Blanchard <anton@samba.org>,
       intermezzo-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Peter Braam <braam@clusterfs.com>, arjanv@redhat.com, akpm@osdl.org
Subject: Re: [PATCH]InterMezzo Patch against linux-2.6.6
In-Reply-To: <55980.202.38.64.248.1084303628.squirrel@webmail.ustc.edu.cn>
Message-ID: <Pine.LNX.4.58.0405121631200.3636@evo.osdl.org>
References: <55980.202.38.64.248.1084303628.squirrel@webmail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 May 2004, Yang, Chen wrote:
>
>    Below is the patch of InterMezzo again linux-2.6.6, I can confirm that
> it's effective. I'm sad to see it's removed in bkl. It seems that this
> is the last patch for InterMezzo. :(

It's removed because Peter seems to not want to support it any more, and 
there didn't seem to be any usage. But if people out there are actually 
using it, and somebody wants to support it _and_ it is in good working 
state for 2.6.x, we could certainly bring it back to life.

But if you only do this because you want to fix warnings that people have 
posted about the sources, and you're not actually seriously using it and 
maintaining it, then I'll just apply this patch against plain 2.6.6 (so 
that it doesn't go away if somebody wants to resurrect it later).

In other words - holler if you want to seriously support it. We're not 
deleting it to be spiteful..

		Linus
