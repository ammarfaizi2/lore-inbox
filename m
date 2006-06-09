Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWFIU2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWFIU2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWFIU2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:28:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38620 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932173AbWFIU2o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:28:44 -0400
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, adilger@clusterfs.com, torvalds@osdl.org,
       alex@clusterfs.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060609115936.2fdda6d0.akpm@osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
	 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	 <m33beecntr.fsf@bzzz.home.net>
	 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	 <20060609181020.GB5964@schatzie.adilger.int> <4489C0B8.7050400@garzik.org>
	 <20060609115936.2fdda6d0.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Jun 2006 21:44:04 +0100
Message-Id: <1149885844.22124.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-09 am 11:59 -0700, ysgrifennodd Andrew Morton:
> Today's ext3 is, afaik, 100% on-disk compatible with ext3 from five years
> ago, and probably with RH's 2.2-based implementation.  

If your files are under 2GB long, you've not used any attributes,
SELinux labels or various other things maybe. In the practical real
world case it isn't. I doubt many Fedora/Red Hat users have a single FS
from RHEL4/FC1 onwards that is readable by 2.2 ext3 (or most 2.4 ext3)

OTOH the number of complaints about this is minimal, people want to go
forwards in a controlled manner not backwards.

Alan

