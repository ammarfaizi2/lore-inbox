Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265315AbUFRPWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUFRPWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUFRPTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:19:42 -0400
Received: from [213.146.154.40] ([213.146.154.40]:45503 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265226AbUFRPSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:18:18 -0400
Date: Fri, 18 Jun 2004 16:17:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       Linus <torvalds@osdl.org>, linuxppc64-dev@lists.linuxppc.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
Message-ID: <20040618151753.GA21596@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@osdl.org>, Linus <torvalds@osdl.org>,
	linuxppc64-dev@lists.linuxppc.org,
	LKML <linux-kernel@vger.kernel.org>
References: <20040618165436.193d5d35.sfr@canb.auug.org.au> <40D305B4.4030009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D305B4.4030009@pobox.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 11:09:40AM -0400, Jeff Garzik wrote:
> Stephen Rothwell wrote:
> >Hi Andrew,
> >
> >This patch adds a proc file for viodasd so to make it
> >easier to enumerate the available disks.  It is in a
> >(somewhat) strange format to try for a simple level of
> >compatability with the old viodasd code (that was in a
> >couple of vendor's kernels).
> 
> Exporting redundant information from procfs is a step backwards, since 
> we have sysfs.
> 
> I would prefer not to apply this.  Upstream is for 'getting it right', 
> not for dragging every little vendor kernel hack along.

Agreed.  And the old viodasd reason was rejected exactly because it was
such a f***ing mess.
