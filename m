Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSILHzi>; Thu, 12 Sep 2002 03:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSILHzi>; Thu, 12 Sep 2002 03:55:38 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:20718
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313190AbSILHzh>; Thu, 12 Sep 2002 03:55:37 -0400
Subject: Re: CDROM driver does not support Linux partition tables
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Phil Stracchino <alaric@babcom.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020912050620.GG30234@suse.de>
References: <20020904181952.GA1158@babylon5.babcom.com>
	<1031182512.3017.139.camel@irongate.swansea.linux.org.uk>
	<20020911211959.GA31724@babylon5.babcom.com>
	<1031779715.2838.4.camel@irongate.swansea.linux.org.uk> 
	<20020912050620.GG30234@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 12 Sep 2002 08:59:57 +0100
Message-Id: <1031817597.2994.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 06:06, Jens Axboe wrote:
> > It ought to be supportable on scsi cd or with ide-scsi. ide-cd has no
> > minor space for partitioning, ide-scsi/sr do support partitions.
> 
> The opposite, surely? sr uses one minor per cd-rom, ide-cd has 64.

Brain on stun. Yes ide-scsi is a problem ide-cd gets it right. This is
something that really ought to get fixe durin 2.5

