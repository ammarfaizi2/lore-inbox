Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281093AbRKGXem>; Wed, 7 Nov 2001 18:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281087AbRKGXed>; Wed, 7 Nov 2001 18:34:33 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:3087 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S281084AbRKGXeT>;
	Wed, 7 Nov 2001 18:34:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: ext3 vs resiserfs vs xfs
Date: Wed, 7 Nov 2001 15:33:54 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk> <20011107132552.J5922@lynx.no>
In-Reply-To: <20011107132552.J5922@lynx.no>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E161cCh-0003de-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 7, 2001 12:25, Andreas Dilger wrote:
> If both ext2 and ext3 are compiled into the kernel, then ext3 will try
> first to mount the root fs.  If there is no journal on this fs (check this
> with tune2fs -l <dev>, and look for "has_journal" feature), then it will be
> mounted as ext2.  If you are doing strange things with initrd and modules,

Is there any particular reason why the ext3 driver can't handle mounting both 
ext2 and ext3 filesystems? 

-Ryan

