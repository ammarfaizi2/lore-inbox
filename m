Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUFRPJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUFRPJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUFRPJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:09:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36016 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261405AbUFRPJz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:09:55 -0400
Message-ID: <40D305B4.4030009@pobox.com>
Date: Fri, 18 Jun 2004 11:09:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Andrew Morton <akpm@osdl.org>, Linus <torvalds@osdl.org>,
       linuxppc64-dev@lists.linuxppc.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
References: <20040618165436.193d5d35.sfr@canb.auug.org.au>
In-Reply-To: <20040618165436.193d5d35.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Hi Andrew,
> 
> This patch adds a proc file for viodasd so to make it
> easier to enumerate the available disks.  It is in a
> (somewhat) strange format to try for a simple level of
> compatability with the old viodasd code (that was in a
> couple of vendor's kernels).

Exporting redundant information from procfs is a step backwards, since 
we have sysfs.

I would prefer not to apply this.  Upstream is for 'getting it right', 
not for dragging every little vendor kernel hack along.

	Jeff


