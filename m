Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319400AbSIFVAP>; Fri, 6 Sep 2002 17:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319396AbSIFU7l>; Fri, 6 Sep 2002 16:59:41 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:63990
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319397AbSIFU6b>; Fri, 6 Sep 2002 16:58:31 -0400
Subject: Re: ext3 corruption on 2.4.18 (LVM, vt82c586b, no DMA)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, Marius Gedminas <mgedmin@centras.lt>,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20020906183415.B7946@redhat.com>
References: <20020904102605.GB8576@gintaras> 
	<20020906183415.B7946@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 22:04:06 +0100
Message-Id: <1031346246.10612.92.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 18:34, Stephen C. Tweedie wrote:
> > I gather from Configure.help that DMA is broken on Via VP2, but it is
> > turned off here.
> 
> Unfortunately, if you disable UDMA mode, you also lose the checksums
> between drive and controller which can detect cable data corruption.

I's have to look it up to be sure but I believe the VIA VP2 goes to DMA
not UDMA

