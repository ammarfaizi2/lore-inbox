Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTDPIZr (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 04:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbTDPIZr 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 04:25:47 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:18437 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264266AbTDPIZq (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 04:25:46 -0400
Date: Wed, 16 Apr 2003 12:36:54 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?koi8-r?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DMA transfers in 2.5.67
Message-ID: <20030416123654.A2629@jurassic.park.msu.ru>
References: <yw1x3ckjfs2v.fsf@zaphod.guide> <1050438684.28586.8.camel@dhcp22.swansea.linux.org.uk> <yw1xy92be915.fsf@zaphod.guide> <1050439715.28586.17.camel@dhcp22.swansea.linux.org.uk> <yw1xptnne7lv.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <yw1xptnne7lv.fsf@zaphod.guide>; from mru@users.sourceforge.net on Wed, Apr 16, 2003 at 12:09:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 12:09:00AM +0200, Måns Rullgård wrote:
> Btw, I just noticed that hard disk throughput is much lower with 2.5
> than 2.4.  With 2.4.21-pre5 I get ~40 MB/s, but with 2.5.67 the speed
> drops to 25-30 MB/s.  Everything according to hdparm.  Is it possible
> that DMA is generally slow for some reason?

Possible reason is that in 2.4 we've forced reasonable latency timer
value for all PCI devices, while in 2.5 we haven't as yet.

Ivan.
