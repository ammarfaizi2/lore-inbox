Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVBJPVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVBJPVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVBJPVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:21:04 -0500
Received: from pat.uio.no ([129.240.130.16]:61899 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262137AbVBJPU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:20:59 -0500
Subject: Re: [NFS] Re: Irix NFS server usual problem [patch, fc3
	2.6.10-1,760_FC3]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
In-Reply-To: <20050210124832.GA23320@dspnet.fr.eu.org>
References: <20050207221638.GA18723@dspnet.fr.eu.org>
	 <1107816524.9970.8.camel@lade.trondhjem.org>
	 <20050210124832.GA23320@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 10:20:44 -0500
Message-Id: <1108048844.9840.55.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.448, required 12,
	autolearn=disabled, AWL 2.50, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 10.02.2005 Klokka 13:48 (+0100) skreiv Olivier Galibert:

> If the patch looks like it's going to be accepted, I'll send the
> (trivial) mount changes to whoever the util-linux maintainer is.  And
> does someone happens to know who maintains the mount/nfs options man
> page?

No. No more hacks and/or mount options for legacy issues in the mainline
NFS client please: there are already too many of them in there.

A permanent fix probably ought to involve removing our current
dependency on using the server-generated readdir cookies as
telldir/seekdir offsets.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

