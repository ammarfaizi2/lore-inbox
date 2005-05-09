Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVEIPqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVEIPqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 11:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVEIPqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 11:46:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58273 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261432AbVEIPqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 11:46:50 -0400
Subject: Re: [PATCH] Support for dx directories in ext3_get_parent (NFSD)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: 7eggert@gmx.de
Cc: Andreas Dilger <adilger@clusterfs.com>,
       Henrik =?ISO-8859-1?Q?Grubbstr=F6m?= <grubba@grubba.org>,
       Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <E1DV9BT-0000v0-1H@be1.7eggert.dyndns.org>
References: <42chI-3Rf-49@gated-at.bofh.it> <42cKy-4jT-9@gated-at.bofh.it>
	 <E1DV9BT-0000v0-1H@be1.7eggert.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115653547.15542.22.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 09 May 2005 16:45:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-05-09 at 15:24, Bodo Eggert  wrote:
> Andreas Dilger <adilger@clusterfs.com> wrote:
> 
> > +     if (namelen > 2 || name[0] != '.'||(name[1] != '.' && name[1] != '\0')){
> 
> The patch was supposed to affect only '..'.

"." is an equivalent special case in htree.  It seems reasonable to
include it here for completeness.

--Stephen

