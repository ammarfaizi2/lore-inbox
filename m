Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVKNXRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVKNXRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVKNXRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:17:54 -0500
Received: from pat.uio.no ([129.240.130.16]:50918 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751275AbVKNXRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:17:54 -0500
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, dhowells@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051114150347.1188499e.akpm@osdl.org>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>
	 <20051114150347.1188499e.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 18:17:33 -0500
Message-Id: <1132010253.8802.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.871, required 12,
	autolearn=disabled, AWL 1.94, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 15:03 -0800, Andrew Morton wrote:

> I think we need an NFS implementation and some numbers which make it
> interesting.  Or at least, some AFS numbers, some explanation as to why
> they can be extrapolated to NFS and some degree of interest from the NFS
> guys.   Ditto CIFS.

There is a lot of interest from the HPC community for this sort of thing
on NFS. Basically, it will help server scalability for projects that
have large numbers of read-only files accessed by large numbers of
clients.

AFAIK, Steve Dickson (steved@redhat.com) is working on the NFS hooks for
FS-Cache.

Cheers,
  Trond

