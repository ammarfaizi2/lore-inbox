Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263051AbVCMGRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbVCMGRS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 01:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVCMGRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 01:17:14 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:54764 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S263051AbVCMGQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 01:16:45 -0500
Date: Sat, 12 Mar 2005 22:16:34 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: nfs@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] inconsistent NFS stat cache (NFS on ext3, 2.6.11)
In-Reply-To: <1110690267.24123.7.camel@lade.trondhjem.org>
Message-ID: <Pine.GSO.4.44.0503122216030.5685-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a known problem. Turn off the (default - grrr) subtree checking
> export option on the server, and it will all work properly. The subtree
> checking option violates the NFS standards for filehandle generation in
> so many ways, that it isn't even funny.

Thanks Trond.  no_subtree_check fixes the problem.

-Junfeng

