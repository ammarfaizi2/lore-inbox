Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVGCQE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVGCQE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 12:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVGCQE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 12:04:58 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:18440 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261461AbVGCPtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 11:49:09 -0400
To: frankvm@frankvm.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050703141028.GB1298@janus> (message from Frank van Maarseveen
	on Sun, 3 Jul 2005 16:10:28 +0200)
Subject: Re: FUSE merging? (2)
References: <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu> <20050702160002.GA13730@janus> <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu> <20050703112541.GA32288@janus> <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu> <20050703141028.GB1298@janus>
Message-Id: <E1Dp6hK-00056d-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 03 Jul 2005 17:47:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > But that's not really acceptable (see previous audit case) unless FUSE
> > > refuses to mount on non-leaf dirs.
> > 
> > I don't think the audit case is important.  It's easy to work around
> > it manually by the sysadmin, and for the automatic case it doesn't
> > really matter (as detailed above).
> 
> Note that the audit case "as user" is less important than the root case. I
> consider the latter very important and EACCES will break it when FUSE
> permits mounting on non-leaf dirs.

OK.  Can you tell me, why you consider it important?  And what's your
proposal for dealing with it?

Refusing to mount on non-leaf dir is not a solution, since it would
still allow arbitrary hiding.

Miklos
