Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbUKVQgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbUKVQgB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbUKVQeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:34:04 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:28549 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262162AbUKVQC7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:02:59 -0500
Date: Mon, 22 Nov 2004 08:02:46 -0800
From: Larry McVoy <lm@bitmover.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Problem with linux-2.6 BK repository on BKbkits?
Message-ID: <20041122160246.GA3683@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <1101122708.18623.16.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101122708.18623.16.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 11:25:08AM +0000, Anton Altaparmakov wrote:
> [snip]
> Applying   1 revisions to net/ipv4/netfilter/ipt_CLUSTERIP.c
> fk cache: insert error for johnrose@austin.ibm.com[greg]|
> drivers/pci/hotplug/rpaphp_pci.c|20210428163018
> insert: File exists
> Applying   1 revisions to drivers/pci/hotplug/rpaphp_pci.c
> [snip]

It's pretty harmless and will be fixed in 3.2.4 (due out pretty soon).

It's a legacy thing from the very early days of BK and the only BK tree
which makes use of it is the BK source tree itself so we dropped it.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
