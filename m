Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVEIQzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVEIQzn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 12:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVEIQzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 12:55:43 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:31448 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261152AbVEIQzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 12:55:39 -0400
Date: Mon, 9 May 2005 18:55:24 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: 7eggert@gmx.de, Andreas Dilger <adilger@clusterfs.com>,
       Henrik =?ISO-8859-1?Q?Grubbstr=F6m?= <grubba@grubba.org>,
       Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Support for dx directories in ext3_get_parent (NFSD)
In-Reply-To: <1115653547.15542.22.camel@sisko.sctweedie.blueyonder.co.uk>
Message-ID: <Pine.LNX.4.58.0505091854060.3930@be1.lrz>
References: <42chI-3Rf-49@gated-at.bofh.it> <42cKy-4jT-9@gated-at.bofh.it> 
 <E1DV9BT-0000v0-1H@be1.7eggert.dyndns.org> <1115653547.15542.22.camel@sisko.sctweedie.blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, Stephen C. Tweedie wrote:
> On Mon, 2005-05-09 at 15:24, Bodo Eggert  wrote:
> > Andreas Dilger <adilger@clusterfs.com> wrote:
> > 
> > > +     if (namelen > 2 || name[0] != '.'||(name[1] != '.' && name[1] != '\0')){
> > 
> > The patch was supposed to affect only '..'.
> 
> "." is an equivalent special case in htree.  It seems reasonable to
> include it here for completeness.

OK, but the comment should be adjusted.
-- 
Backups? We doan NEED no steenking baX%^~,VbKx NO CARRIER 
