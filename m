Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVDMSmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVDMSmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVDMSkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:40:25 -0400
Received: from mail.shareable.org ([81.29.64.88]:29857 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261185AbVDMSg7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:36:59 -0400
Date: Wed, 13 Apr 2005 19:36:51 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: aia21@cam.ac.uk, 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050413183651.GA15334@mail.shareable.org>
References: <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <Pine.LNX.4.60.0504122117010.26320@hermes-1.csi.cam.ac.uk> <20050412215220.GA23321@mail.shareable.org> <E1DLdwo-0004SE-00@dorka.pomaz.szeredi.hu> <20050413170222.GJ12825@mail.shareable.org> <E1DLlgD-0004xe-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLlgD-0004xe-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > Yet, the results from stat() don't distinguish the number spaces,
> > and "ls" doesn't map the numbers to names properly in the wrong
> > space.
> 
> Well you can use "ls -n".  It's up to the tools to present the
> information you want in the way you want it.  If a tool can't do that,
> tough, but you are not worse off than if the information is not
> available _at_all_.

Well, how do you currently provide access to the information that's
not presentable through stat()?

-- Jamie
