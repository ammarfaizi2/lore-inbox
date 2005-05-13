Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVEMQSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVEMQSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 12:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVEMQSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 12:18:17 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:39808 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262417AbVEMQSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 12:18:12 -0400
Subject: Re: Re[2]: ata over ethernet question
From: Dmitry Yusupov <dmitry_yus@yahoo.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Sander <sander@humilis.net>, David Hollis <dhollis@davehollis.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050513081617.GC32546@infradead.org>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
	 <1115236116.7761.19.camel@dhollis-lnx.sunera.com>
	 <1104082357.20050504231722@dns.toxicfilms.tv>
	 <1115305794.3071.5.camel@dhollis-lnx.sunera.com>
	 <20050507150538.GA800@favonius>
	 <Pine.LNX.4.60.0505102352430.9008@poirot.grange>
	 <1115923927.5042.18.camel@mulgrave> <1115924747.25161.150.camel@beastie>
	 <1115925312.5042.24.camel@mulgrave> <1115927058.25161.166.camel@beastie>
	 <20050513081617.GC32546@infradead.org>
Content-Type: text/plain
Date: Fri, 13 May 2005 09:18:10 -0700
Message-Id: <1116001090.25161.211.camel@beastie>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 09:16 +0100, Christoph Hellwig wrote:
> On Thu, May 12, 2005 at 12:44:18PM -0700, Dmitry Yusupov wrote:
> > i'm just reacting on "bloated" wording. It really depends on
> > implementation and design. If you were talking about amount of code in
> > the kernel, than take a look on open-iscsi(just one file iscsi_tcp.c)
> > and IET where we doing a lot of management stuff in user-space. It is
> > not that much code in the kernel, really, but it is doing x10 times more
> > useful things comparing to nbd and yet compliant with RFC.
> 
> Keeping code out of the kernel is really nice, but that doesn't meant it
> isn't bloat - the bloat is just in userland.

well, "userland" == "bloatland" anyways... Multiple discovery methods,
configuration database, bunch of security protocols, etc... all this of
course will make it "slightly" :) bigger than nbd. But again, for a good
reason and better usefulness.

Dmitry

