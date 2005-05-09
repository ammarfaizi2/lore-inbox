Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVEIO20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVEIO20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVEIOZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:25:43 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:40647 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261391AbVEIOZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:25:02 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [PATCH] Support for dx directories in ext3_get_parent (NFSD)
To: Andreas Dilger <adilger@clusterfs.com>,
       Henrik =?ISO-8859-1?Q?Grubbstr=F6m?= <grubba@grubba.org>,
       sct@redhat.com, akpm@osdl.org, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Reply-To: 7eggert@gmx.de
Date: Mon, 09 May 2005 16:24:26 +0200
References: <42chI-3Rf-49@gated-at.bofh.it> <42cKy-4jT-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1DV9BT-0000v0-1H@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> wrote:

> +     if (namelen > 2 || name[0] != '.'||(name[1] != '.' && name[1] != '\0')){

The patch was supposed to affect only '..'.

Maybe you can add a 'unlikely', too.
-- 
A "sucking chest wound" is nature's way of telling you to slow down. 

