Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWHRBF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWHRBF0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 21:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWHRBF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 21:05:26 -0400
Received: from ihug-mail.icp-qv1-irony1.iinet.net.au ([203.59.1.195]:33127
	"EHLO mail-ihug.icp-qv1-irony1.iinet.net.au") by vger.kernel.org
	with ESMTP id S932209AbWHRBFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 21:05:25 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.08,140,1154880000"; 
   d="scan'208"; a="606218638:sNHT262627952"
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's
	list
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <1155862725.2997.17.camel@raven.themaw.net>
References: <1155743399.5683.13.camel@localhost>
	 <20060813133935.b0c728ec.akpm@osdl.org>
	 <20060813012454.f1d52189.akpm@osdl.org>
	 <5910.1155741329@warthog.cambridge.redhat.com>
	 <13319.1155744959@warthog.cambridge.redhat.com>
	 <1155862725.2997.17.camel@raven.themaw.net>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 09:05:25 +0800
Message-Id: <1155863126.2997.20.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 08:58 +0800, Ian Kent wrote:

> Sorry I didn't look at this more closely earlier.
> 
> Just looking at this function alone it looks to me like it is
> essentially part of a dentry instantiation which would mean a negative
> dentry is perfectly valid at the point above.

I looked again, scratch this comment.

Ian

