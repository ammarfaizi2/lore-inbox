Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291766AbSCDFlP>; Mon, 4 Mar 2002 00:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291767AbSCDFlG>; Mon, 4 Mar 2002 00:41:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28167 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291766AbSCDFk7>;
	Mon, 4 Mar 2002 00:40:59 -0500
Message-ID: <3C8308FE.FC4FA42@mandrakesoft.com>
Date: Mon, 04 Mar 2002 00:41:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Daniel Phillips <phillips@bonn-fries.net>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] delayed disk block allocation
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin> <20020304050450.GF353@matchmail.com> <20020303223103.J4188@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> Actually, there are a whole bunch of performance issues with 1kB block
> ext2 filesystems.  For very small files, you are probably better off
> to have tails in EAs stored with the inode, or with other tails/EAs in
> a shared block.  We discussed this on ext2-devel a few months ago, and
> while the current ext2 EA design is totally unsuitable for that, it
> isn't impossible to fix.

IMO the ext2 filesystem design is on it's last legs ;-)   I tend to
think that a new filesystem efficiently handling these features is far
better than dragging ext2 kicking and screaming into the 2002's :)

-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
