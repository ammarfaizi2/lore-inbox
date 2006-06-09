Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWFIQ74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWFIQ74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWFIQ7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:59:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34225 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030209AbWFIQ7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:59:54 -0400
Subject: Re: [RFC 0/13] extents and 48bit ext3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: cmm@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <4488E1A4.20305@garzik.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	 <4488E1A4.20305@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Jun 2006 18:14:54 +0100
Message-Id: <1149873294.22124.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-08 am 22:49 -0400, ysgrifennodd Jeff Garzik:
> People (including me) still switch back and forth between ext2 and ext3 
> mounts of the same filesystem on occasion.  I think creating an "ext4" 
> would allow for greater developer flexibility in implementing new 
> features and ditching old ones -- while also emphasizing to the user 
> that switching back and forth between ext4 and ext[23] is a bad idea.

I would agree with this, particularly as ext3 and ext4 are quite small
in the kernel side of things and people needing 48bit extents are
probably not trying to run on 8MB of flash.

Alan

