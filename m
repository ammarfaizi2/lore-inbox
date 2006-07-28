Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWG1Izf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWG1Izf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWG1Ize
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:55:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:11651 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932587AbWG1Ize (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:55:34 -0400
Message-ID: <44C9D0FE.9090004@garzik.org>
Date: Fri, 28 Jul 2006 04:55:26 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] Permit filesystem local caching and NFS superblock
 sharing  [try #11]
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> These patches make it possible to share NFS superblocks between related
> mounts, where "related" means on the same server and FSID. Inodes and dentries
> will be shared where the NFS filehandles are the same (for example if two NFS3
> files come from the same export but from different mounts, such as is not
> uncommon with autofs on /home).
> 
> These patches also add local caching for network filesystems such as NFS and
> AFS.

I'm really looking forward to seeing this in the upstream kernel... 
thanks for your continued work on this.

(Although I admit to not reviewing 100% of the code)

	Jeff



