Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWCCNBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWCCNBr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWCCNBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:01:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50660 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751389AbWCCNBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:01:46 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <27600.1141390810@warthog.cambridge.redhat.com> 
References: <27600.1141390810@warthog.cambridge.redhat.com>  <20060303034552.5fcedc49.akpm@osdl.org> <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> <25676.1141385408@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/5] Optimise d_find_alias() 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 03 Mar 2006 13:01:31 +0000
Message-ID: <27648.1141390891@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> 		smp_rb();

I believe that should be smp_rmb().

David
