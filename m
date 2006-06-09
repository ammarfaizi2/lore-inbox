Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965282AbWFIOct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965282AbWFIOct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965278AbWFIOct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:32:49 -0400
Received: from [80.71.248.82] ([80.71.248.82]:61128 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S965269AbWFIOcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:32:48 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Christoph Hellwig <hch@infradead.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net>
	<44898476.80401@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
In-Reply-To: <44898476.80401@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 10:23:50 -0400")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Date: Fri, 09 Jun 2006 18:34:39 +0400
Message-ID: <m33beee6tc.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jeff Garzik (JG) writes:

 JG> And thus, inodes are progressively incompatible with older
 JG> kernels. Boot into an older kernel, and you can now only read half
 JG> your filesystem (if it even allows mount at all).

nope, you aren't allowed to mount fs with extents-enabled files
by ext3 which has no the feature compiled in. the same will
happen if you call it ext4.

thanks, Alex
