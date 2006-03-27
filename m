Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWC0MN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWC0MN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 07:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWC0MN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 07:13:29 -0500
Received: from mailgw3.ericsson.se ([193.180.251.60]:43490 "EHLO
	mailgw3.ericsson.se") by vger.kernel.org with ESMTP
	id S1750943AbWC0MN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 07:13:29 -0500
Date: Mon, 27 Mar 2006 14:13:23 +0200 (CEST)
From: Per Liden <per.liden@ericsson.com>
X-X-Sender: eperlid@ulinpc219.uab.ericsson.se
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup for net/tipc/name_distr.c::tipc_named_node_up()
In-Reply-To: <9a8748490603260335g4e527ae9had20de42041c3983@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0603270945030.11640@ulinpc219.uab.ericsson.se>
References: <200603190045.24176.jesper.juhl@gmail.com> 
 <Pine.LNX.4.64.0603221049140.6949@ulinpc219.uab.ericsson.se>
 <9a8748490603260335g4e527ae9had20de42041c3983@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 27 Mar 2006 12:13:25.0556 (UTC) FILETIME=[D960F740:01C65197]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006, Jesper Juhl wrote:

[...]
> > > Patch does the following:
> > >
> > >  - Change a few pointer assignments from 0 to NULL (makes sparse happy).
> >
> > Ok.
> >
> > >  - Move a few variable assignment outside the tipc_nametbl_lock lock.
> >
> > Ok.
> >
> 
> Do you want a new patch with just these bits in it or will you take
> care of it yourself?

The first one was has already been fixed with another patch that's in 
Linus tree right now. The second one is borderline-cosmetic so I'll fix 
that the next time I'm making changes in that area.

/Per
