Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317660AbSGOTkR>; Mon, 15 Jul 2002 15:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317659AbSGOTkQ>; Mon, 15 Jul 2002 15:40:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317658AbSGOTkP>;
	Mon, 15 Jul 2002 15:40:15 -0400
Message-ID: <3D332543.96C7E589@zip.com.au>
Date: Mon, 15 Jul 2002 12:40:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sam Vilain <sam@vilain.net>,
       dax@gurulabs.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
References: <1026739383.13885.114.camel@irongate.swansea.linux.org.uk> <1026740450.21656.355.camel@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> ...
> If ext3 would promise to make fsync(file) sufficient forever, it might
> help the mta authors tune.

ext3 promises.  This side-effect is bolted firmly into the design
of ext3 and it's hard to see any way in which it will go away.

-
