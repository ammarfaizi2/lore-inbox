Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWB1K23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWB1K23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWB1K23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:28:29 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9384 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932144AbWB1K22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:28:28 -0500
Subject: Re: LibPATA code issues / 2.6.15.4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, David Greaves <david@dgreaves.com>,
       Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <4403CEA9.4080603@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34>
	 <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34>
	 <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com>
	 <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34>
	 <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com>
	 <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
	 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca>
	 <4403A84C.6010804@gmail.com>  <4403CEA9.4080603@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Feb 2006 10:32:44 +0000
Message-Id: <1141122764.3089.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-27 at 23:16 -0500, Mark Lord wrote:
> Or maybe a whitelist instead, since nearly all existing hardware
> pre-dates FUA commands.

For controllers just add it as a host flag and it can be handled the
same way as LBA48 is right now. It may also be some hosts can issue FUA
with a bit of bandaging (state machine resets/pio etc)

Alan

