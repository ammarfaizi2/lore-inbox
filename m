Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWIBEtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWIBEtp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 00:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWIBEtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 00:49:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:13974 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750711AbWIBEto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 00:49:44 -0400
Message-Id: <1157172583.9610.269973398@webmail.messagingengine.com>
X-Sasl-Enc: Z9wL8ZPxkk/mqKpImamvVX6EjQweHx58Dcp045WBwG+/ 1157172583
From: "Ian Kent" <raven@themaw.net>
To: "Andrew Morton" <akpm@osdl.org>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: "David Howells" <dhowells@redhat.com>,
       "Linus Torvalds" <torvalds@osdl.org>, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
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
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
   sharing [try #13]
In-Reply-To: <20060901195009.187af603.akpm@osdl.org>
Date: Sat, 02 Sep 2006 12:49:43 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 1 Sep 2006 19:50:09 -0700, "Andrew Morton" <akpm@osdl.org> said:
> On Fri, 01 Sep 2006 13:00:44 -0400
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > On Fri, 2006-09-01 at 09:34 -0700, Andrew Morton wrote:
> > 
> > > nfs automounter submounts are still broken in Trond's tree, btw.  Are we stuck?
> > 
> > You mean autofs indirect maps?
> 
> I don't know that that is.
> 

The mount that Andrew is a "host" type mount.
autofs gets the host name as a key and is expected to mount all
filesystems exported from the host. It does this by attempting to
mounting each export in shortest to longest order (to take account
of nesting of the mounts).

Ian
Ian


-- 
VGER BF report: H 3.10862e-15
