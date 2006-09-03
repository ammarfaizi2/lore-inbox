Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752105AbWICGnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbWICGnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 02:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbWICGnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 02:43:09 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41922 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752103AbWICGnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 02:43:06 -0400
X-Sasl-enc: xgM6rFgUP1Pz1kQEx3UXYF6fXlsg1UO1b3nJB/bHzPSK 1157265784
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060902233023.ce544a00.akpm@osdl.org>
References: <20060831102127.8fb9a24b.akpm@osdl.org>
	 <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <9534.1157116114@warthog.cambridge.redhat.com>
	 <20060901093451.87aa486d.akpm@osdl.org>
	 <1157130044.5632.87.camel@localhost>
	 <20060901195009.187af603.akpm@osdl.org>
	 <1157170272.3307.5.camel@raven.themaw.net>
	 <20060901225853.0171fd29.akpm@osdl.org>
	 <1157264490.3520.16.camel@raven.themaw.net>
	 <20060902233023.ce544a00.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 03 Sep 2006 14:43:00 +0800
Message-Id: <1157265781.3520.18.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-02 at 23:30 -0700, Andrew Morton wrote:
> On Sun, 03 Sep 2006 14:21:30 +0800
> Ian Kent <raven@themaw.net> wrote:
> 
> > I guess you haven't got the autofs module loaded instead of autofs4 by
> > mistake.
> 
> Nope.
> 
> > So I wonder what the different is between the setups?
> 
> Beats me.  Maybe cook up a debug patch?

OK.

Could you add "--debug" to DAEMONOPTIONS in /etc/sysconfig/autofs and
post the output so I can get some idea where to put the prints please.

Ian



-- 
VGER BF report: H 7.45677e-07
