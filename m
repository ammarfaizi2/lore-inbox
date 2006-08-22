Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWHVELR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWHVELR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 00:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWHVELR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 00:11:17 -0400
Received: from pat.uio.no ([129.240.10.4]:32692 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932093AbWHVELQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 00:11:16 -0400
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's
	list [try #2]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <Pine.LNX.4.64.0608221124420.4543@raven.themaw.net>
References: <Pine.LNX.4.64.0608212112350.28902@raven.themaw.net>
	 <Pine.LNX.4.64.0608211932300.27275@raven.themaw.net>
	 <Pine.LNX.4.64.0608202223220.29268@raven.themaw.net>
	 <20060819094840.083026fd.akpm@osdl.org>
	 <13319.1155744959@warthog.cambridge.redhat.com>
	 <1155743399.5683.13.camel@localhost>
	 <20060813133935.b0c728ec.akpm@osdl.org>
	 <20060813012454.f1d52189.akpm@osdl.org>
	 <5910.1155741329@warthog.cambridge.redhat.com>
	 <2138.1155893924@warthog.cambridge.redhat.com>
	 <3976.1156079732@warthog.cambridge.redhat.com>
	 <30856.1156153373@warthog.cambridge.redhat.com>
	 <323.1156162567@warthog.cambridge.redhat.com>
	 <15387.1156173472@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0608221124420.4543@raven.themaw.net>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 00:10:58 -0400
Message-Id: <1156219858.5597.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.783, required 12,
	autolearn=disabled, AWL 0.71, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 11:29 +0800, Ian Kent wrote:

> There isn't any way to tell a nohide from a non-nohide mount from the 
> expots list.

Why do you care? NFS shouldn't be barfing if you try to mount the
filesystem yourself. If it does, then it is broken.

> There are inconsistencies with the contents of /proc/mounts between OS 
> versions (perhaps kernel version).

Huh? The NFS output for /proc/mounts hasn't changed.

> There is no way to tell a nohide mounted filesystem from the output of 
> /proc/mounts if it does happen to appear in it.

Why do you care?

  Trond

