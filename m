Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWCGNXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWCGNXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWCGNXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:23:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49640 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751297AbWCGNXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:23:23 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060307113514.GX20691@devserv.devel.redhat.com> 
References: <20060307113514.GX20691@devserv.devel.redhat.com>  <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> <15962.1141729721@warthog.cambridge.redhat.com> 
To: Alexander Viro <aviro@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
       Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix multiple blockdev-based filesystem mounts 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 07 Mar 2006 13:23:02 +0000
Message-ID: <25760.1141737782@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <aviro@redhat.com> wrote:

> Please, merge them in one; this one fixes a bug in ->get_sb() patch and since
> it wasn't merged in mainline yet, there's no reason to keep them separate.

I've re-issued that patches (as [try #6]) with this and other fixes merged
into it.

David
