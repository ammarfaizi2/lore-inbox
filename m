Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWHJVKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWHJVKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWHJVKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:10:07 -0400
Received: from [80.71.248.82] ([80.71.248.82]:64473 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1750820AbWHJVKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:10:01 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
References: <1155172622.3161.73.camel@localhost.localdomain>
	<20060809233914.35ab8792.akpm@osdl.org> <44DB8036.5020706@us.ibm.com>
	<44DB936D.2080909@garzik.org> <20060810132720.4d9fced4.akpm@osdl.org>
	<44DB9E6C.9070808@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: CFS
Date: Fri, 11 Aug 2006 01:11:23 +0400
In-Reply-To: <44DB9E6C.9070808@garzik.org> (Jeff Garzik's message of "Thu, 10 Aug 2006 17:00:28 -0400")
Message-ID: <m3irl0l2is.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jeff Garzik (JG) writes:

 >> A buffer_head is the kernel's sole abstraction of a disk block. 
 >> Filesystems use disk blocks a lot, and they need such an abstraction.

 JG> IMO Al Viro work has shown that you can do pagecache I/O without needing 
 JG> such a heavyweight system.

in delayed allocation patch for ext3 (ontop of extents) we do use
bio's for data.

thanks, Alex
