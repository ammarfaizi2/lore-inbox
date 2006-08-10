Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbWHJF7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWHJF7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWHJF7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:59:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15568 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161046AbWHJF7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:59:09 -0400
Message-ID: <44DACB21.9080002@garzik.org>
Date: Thu, 10 Aug 2006 01:58:57 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: cmm@us.ibm.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Forking ext4 filesystem and JBD2
References: <1155172597.3161.72.camel@localhost.localdomain>
In-Reply-To: <1155172597.3161.72.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao wrote:
> This series of patch forkes a new filesystem, ext4, from the current
> ext3 filesystem, as the code base to work on, for the big features such
> as extents and larger fs(48 bit blk number) support, per our discussion
> on lkml a few weeks ago. 
[...]
> Any comments? Could we add ext4/jbd2 to mm tree for a wider testing?

ext4 developers should create a git tree with the consensus-accepted 
patches.

That way Linus can pull as soon as the merge window opens, Andrew is 
guaranteed to have the latest in his -mm tree, and users and other 
kernel hackers can easily follow the development without having to 
gather scattered patches from lkml.

	Jeff


