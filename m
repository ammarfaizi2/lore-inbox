Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWIEKOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWIEKOe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWIEKOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:14:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:29673 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751247AbWIEKOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:14:33 -0400
X-Sasl-enc: F8efkPPXFyKd4OoNfLAQWM6BMySBA7xAXTsuaW4wfACH 1157451271
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <3840.1157449688@warthog.cambridge.redhat.com>
References: <1157424937.3002.4.camel@raven.themaw.net>
	 <20060901195009.187af603.akpm@osdl.org>
	 <20060831102127.8fb9a24b.akpm@osdl.org>
	 <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <9534.1157116114@warthog.cambridge.redhat.com>
	 <20060901093451.87aa486d.akpm@osdl.org>
	 <1157130044.5632.87.camel@localhost>
	 <28945.1157370732@warthog.cambridge.redhat.com>
	 <1157376295.3240.13.camel@raven.themaw.net>
	 <1157421445.5510.13.camel@localhost>
	 <3840.1157449688@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 18:14:24 +0800
Message-Id: <1157451264.4133.16.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 10:48 +0100, David Howells wrote:
> Ian Kent <raven@themaw.net> wrote:
> 
> > Why the hell shouldn't it be able to do an mkdir!
> 
> The use of mkdir in this manner has to be considered a bug.  You don't know
> that the object at that name on the server is a directory.  It might be a
> symbolic link.

Fair call.



