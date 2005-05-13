Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVEMIRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVEMIRd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVEMIRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:17:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17628 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262295AbVEMIQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:16:27 -0400
Date: Fri, 13 May 2005 09:16:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Yusupov <dmitry_yus@yahoo.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Sander <sander@humilis.net>, David Hollis <dhollis@davehollis.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Re[2]: ata over ethernet question
Message-ID: <20050513081617.GC32546@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dmitry Yusupov <dmitry_yus@yahoo.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Sander <sander@humilis.net>, David Hollis <dhollis@davehollis.com>,
	Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <1416215015.20050504193114@dns.toxicfilms.tv> <1115236116.7761.19.camel@dhollis-lnx.sunera.com> <1104082357.20050504231722@dns.toxicfilms.tv> <1115305794.3071.5.camel@dhollis-lnx.sunera.com> <20050507150538.GA800@favonius> <Pine.LNX.4.60.0505102352430.9008@poirot.grange> <1115923927.5042.18.camel@mulgrave> <1115924747.25161.150.camel@beastie> <1115925312.5042.24.camel@mulgrave> <1115927058.25161.166.camel@beastie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115927058.25161.166.camel@beastie>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 12:44:18PM -0700, Dmitry Yusupov wrote:
> i'm just reacting on "bloated" wording. It really depends on
> implementation and design. If you were talking about amount of code in
> the kernel, than take a look on open-iscsi(just one file iscsi_tcp.c)
> and IET where we doing a lot of management stuff in user-space. It is
> not that much code in the kernel, really, but it is doing x10 times more
> useful things comparing to nbd and yet compliant with RFC.

Keeping code out of the kernel is really nice, but that doesn't meant it
isn't bloat - the bloat is just in userland.

> yeah, generic transport, recovery levels, direct data placement for HW
> HBAs, etc, etc... it is all *must* features for enterprise's SAN
> deployment. So, yes, there is a price as usual.

I'm sure your marketing department can use all these buzzwords to sell
NICs to CTOs and CEOs, but else..

