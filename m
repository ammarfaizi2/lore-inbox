Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVELTQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVELTQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 15:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVELTQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 15:16:00 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:41433 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261417AbVELTPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 15:15:30 -0400
Subject: Re: Re[2]: ata over ethernet question
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Dmitry Yusupov <dmitry_yus@yahoo.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sander <sander@humilis.net>,
       David Hollis <dhollis@davehollis.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <1115924747.25161.150.camel@beastie>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
	 <1115236116.7761.19.camel@dhollis-lnx.sunera.com>
	 <1104082357.20050504231722@dns.toxicfilms.tv>
	 <1115305794.3071.5.camel@dhollis-lnx.sunera.com>
	 <20050507150538.GA800@favonius>
	 <Pine.LNX.4.60.0505102352430.9008@poirot.grange>
	 <1115923927.5042.18.camel@mulgrave>  <1115924747.25161.150.camel@beastie>
Content-Type: text/plain
Date: Thu, 12 May 2005 15:15:12 -0400
Message-Id: <1115925312.5042.24.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-12 at 12:05 -0700, Dmitry Yusupov wrote:
> oh, please! don't compare nbd and iSCSI this way...
> iSCSI is an emerging SAN technology, and the only technology to compare
> is FC.

Well, the question was whether iSCSI could replace nbd; It's rather
difficult to answer that question by comparing iSCSI to FC ...

But even projecting to iSCSI being totally mature, the amount of code
required to conform to the iSCSI standard is easily going to put it 10x
over the amount of code we have in nbd, principally because they're
aimed at solving different problems and nbd achieves a lot of
streamlining by being tied to the linux block subsystem instead of
trying to be a generic transport.

James


