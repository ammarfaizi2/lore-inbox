Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWAaKRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWAaKRW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWAaKRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:17:22 -0500
Received: from quechua.inka.de ([193.197.184.2]:46493 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1750733AbWAaKRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:17:21 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
To: linux-kernel@vger.kernel.org
Date: Tue, 31 Jan 2006 11:17:22 +0100
References: <43DCA097.nailGPD11GI11@burner> <20060129112613.GA29356@merlin.emma.line.org> <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr> <43DD2A8A.nailGVQ115GOP@burner> <787b0d920601291328k52191977h3778a7c833d640f2@mail.gmail.com> <43DE3A99.nail16ZK1MAWN@burner> <787b0d920601300831j99fae82n5d4a5d94f99baafd@mail.gmail.com> <43DE405D.nail2AM2BPF20@burner> <20060130170813.GG19173@merlin.emma.line.org> <43DE495A.nail2BR211K0O@burner> <20060130173028.GA5452@merlin.emma.line.org> <43DE4EC3.nail2D51I6BPD@burner>
User-Agent: KNode/0.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20060131101717.39B7221709@dungeon.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> I am only asking for a unique name space for all devices that talk SCSI.
> 
> And please: read the SCSI Standard on t10.org to learn that ATA is just
> one of many possible SCSI transports.

why do you need it? if you were fine with all cd bunners and dvd burners,
you could use /dev/{cdrw,dvdrw}*. if you also want the dvd device and cd
devices, have a look at /dev/cdrom* and /dev/dvd*. note: you need
to sort out duplicates yourself, for example my laptop has one dvd writer
and thus it shows up as cdrom, cdrw, dvd and dvdrw.

the obvious answer to your question would be: there is none.
as far as I understand the kernel developers, the real answer is:
you application should not need that.

Regards, Andreas

