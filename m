Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUEOR0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUEOR0W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 13:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUEOR0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 13:26:22 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:50564 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S261421AbUEOR0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 13:26:21 -0400
Subject: Re: NFS & long symlinks = stack overflow
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Oleg Drokin <green@linuxhacker.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <20040515135318.GP17014@parcelfarce.linux.theplanet.co.uk>
References: <20040515132149.GA14880@linuxhacker.ru>
	 <20040515135318.GP17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1084641974.3490.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 15 May 2004 13:26:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-15 at 09:53, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> Lovely.  The real limit imposed by client (apparently not enforced, though)
> is PAGE_CACHE_SIZE - 4 - 1.  What are the protocol limits?  I've been looking
> into the same area for other reasons just now and all I could find was NFS v2
> "no more than 1024 bytes", no information on v3 or v4.

NFSv3 and v4 have no set limits on the link length other than that
enforced by the server.

Cheers,
  Trond
