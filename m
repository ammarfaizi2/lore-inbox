Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWH1RTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWH1RTo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWH1RTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:19:44 -0400
Received: from p02c11o141.mxlogic.net ([208.65.145.64]:31365 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S1750753AbWH1RTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:19:43 -0400
Date: Mon, 28 Aug 2006 20:19:26 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: T60 not coming out of suspend to RAM
Message-ID: <20060828171926.GB25491@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060828154242.GB30105@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828154242.GB30105@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 28 Aug 2006 17:25:45.0109 (UTC) FILETIME=[FEA35450:01C6CAC6]
X-Spam: [F=0.0100000000; S=0.010(2006081701)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Pavel Machek <pavel@ucw.cz>:
> Subject: Re: T60 not coming out of suspend to RAM
> 
> On Mon 2006-08-28 16:53:58, Michael S. Tsirkin wrote:
> > OK, it turns out the problem was with running SATA drive in AHCI mode.
> > 
> > After applying the following patch from Forrest Zhao
> > http://lkml.org/lkml/2006/7/20/56
> > both suspend to disk and suspend to ram work fine now.
> > This patch is going into 2.6.18, isn't it?
> 
> Not sure, check latest -rc5, and if it is not there, ask akpm...
> 

Andrew, this is going into 2.6.18, isn't it? I don't see it in -rc5.

-- 
MST
