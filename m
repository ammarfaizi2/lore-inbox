Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSFJLXi>; Mon, 10 Jun 2002 07:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSFJLXh>; Mon, 10 Jun 2002 07:23:37 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:20494 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314529AbSFJLXh>; Mon, 10 Jun 2002 07:23:37 -0400
Date: Mon, 10 Jun 2002 13:23:24 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Promise driver (pdc202xx)]
Message-ID: <20020610112324.GB846@louise.pinerecords.com>
In-Reply-To: <1023666681.1163.4.camel@vaarlahti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 5 days, 16:32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> TX2 (PDC20269)? Disk is new 60GB Seagate Barracuda. U133TX2's BIOS says
> it has enabled UDMA5.
> 
> Driver is: ide-2.4.19-p7.all.convert.10.patch.bz2

This is a bug in the driver. You need to boot with 'ide0=ata66'
(0 being the channel number) to be able to switch to udma3+ modes.

T.
