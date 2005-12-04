Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVLDOyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVLDOyH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 09:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVLDOyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 09:54:07 -0500
Received: from pat.uio.no ([129.240.130.16]:19397 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932236AbVLDOyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 09:54:05 -0500
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: JaniD++ <djani22@dynamicweb.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <011201c5f8e1$557c32a0$0400a8c0@dcccs>
References: <016c01c5f6cc$0e28e6d0$0400a8c0@dcccs>
	 <1133481721.9597.37.camel@lade.trondhjem.org>
	 <00e501c5f809$99c70bc0$0400a8c0@dcccs>
	 <1133622663.7911.5.camel@lade.trondhjem.org>
	 <011201c5f8e1$557c32a0$0400a8c0@dcccs>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 09:53:53 -0500
Message-Id: <1133708033.8016.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.936, required 12,
	autolearn=disabled, AWL 1.88, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-04 at 15:45 +0100, JaniD++ wrote:
> >
> http://client.linux-nfs.org/Linux-2.6.x/2.6.15-rc4/linux-2.6.15-01-nfs-cache-init.dif
> > and
> >
> http://client.linux-nfs.org/Linux-2.6.x/2.6.15-rc4/linux-2.6.15-02-fix_cache_consistency.dif
> >
> > and see if they fix the problem?
> 
> done.
> No change. :(

OK. There is one more patch that I fed into 2.6.15-rc5 and that might
help. Either grab 2.6.15-rc5 from kernel.org, og grab it from

http://client.linux-nfs.org/Linux-2.6.x/2.6.15-rc4/linux-2.6.15-05-fix_attr_updates.dif

Cheers,
 Trond

