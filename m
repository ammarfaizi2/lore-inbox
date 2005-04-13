Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVDMTR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVDMTR1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVDMTRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:17:13 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:63716 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261224AbVDMTQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:16:58 -0400
To: jamie@shareable.org
CC: aia21@cam.ac.uk, 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050413183651.GA15334@mail.shareable.org> (message from Jamie
	Lokier on Wed, 13 Apr 2005 19:36:51 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <Pine.LNX.4.60.0504122117010.26320@hermes-1.csi.cam.ac.uk> <20050412215220.GA23321@mail.shareable.org> <E1DLdwo-0004SE-00@dorka.pomaz.szeredi.hu> <20050413170222.GJ12825@mail.shareable.org> <E1DLlgD-0004xe-00@dorka.pomaz.szeredi.hu> <20050413183651.GA15334@mail.shareable.org>
Message-Id: <E1DLnLp-00054j-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Apr 2005 21:16:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Yet, the results from stat() don't distinguish the number spaces,
> > > and "ls" doesn't map the numbers to names properly in the wrong
> > > space.
> > 
> > Well you can use "ls -n".  It's up to the tools to present the
> > information you want in the way you want it.  If a tool can't do that,
> > tough, but you are not worse off than if the information is not
> > available _at_all_.
> 
> Well, how do you currently provide access to the information that's
> not presentable through stat()?

Obviously I don't.  However that's hardly an argument for providing
even less information.

And stat() btw pretty much covers what information there is to present
for network filesystems and archives, since there _is_ a real
filesystem where the information originated from (though sometimes
it's not a UNIX type of filesystem, in which case there has to be some
mapping of the info).

Miklos
