Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312846AbSDDAVZ>; Wed, 3 Apr 2002 19:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312943AbSDDAVQ>; Wed, 3 Apr 2002 19:21:16 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.25]:65365 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S312846AbSDDAVE>; Wed, 3 Apr 2002 19:21:04 -0500
Message-ID: <3CAB9C68.1A879B4D@chello.nl>
Date: Thu, 04 Apr 2002 02:20:58 +0200
From: Segher Boessenkool <segher@chello.nl>
Reply-To: segher@chello.nl
X-Mailer: Mozilla 4.73C-CCK-MCD {C-UDP; EBM-APPLE} (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Dave Hansen <haveblue@us.ibm.com>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org, Craig Christophel <merlin@transgeek.com>
Subject: Re: [PATCH] shift BKL out of notify_change
In-Reply-To: <3CAB8BB4.8040400@us.ibm.com> <200204032358.g33Nw1S13759@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -    struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
> > +    struct fs_info efs_info = inode->i_sb-nu.generic_sbp;
> 
> What on earth is this change? Some kind of cut-and-paste error?

0x3e --> 0x7e.  Single bit error.  Aieee!


Segher

