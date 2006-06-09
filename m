Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWFIQKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWFIQKS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWFIQKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:10:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030267AbWFIQKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:10:15 -0400
Date: Fri, 9 Jun 2006 09:09:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Gerrit Huizenga <gh@us.ibm.com>
cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3 
In-Reply-To: <E1FojJ7-0002gC-9w@w-gerrit.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0606090907060.5498@g5.osdl.org>
References: <E1FojJ7-0002gC-9w@w-gerrit.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Gerrit Huizenga wrote:
> 
> Jeff's approach taken to the rediculous would mean that we'd have
> ext versions 1-40 by now at least.  I don't think that helps much,
> either.

On the other hand, I _guarantee_ you that it helps that we have ext2-3, 
and not just ext2 (nobody even tried to keep ext1 compatible, thank the 
Gods).

If for no other reason, than the fact that the ext3 development could be 
much more aggressive early on. Exactly because it did NOT screw up the old 
filesystem that everybody else depended on.

So we have empirical evidence that splitting filesystem work up does 
actually help. 

			Linus
