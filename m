Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSHATqG>; Thu, 1 Aug 2002 15:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSHATqG>; Thu, 1 Aug 2002 15:46:06 -0400
Received: from p50887441.dip.t-dialin.net ([80.136.116.65]:18617 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316856AbSHATqG>; Thu, 1 Aug 2002 15:46:06 -0400
Date: Thu, 1 Aug 2002 13:49:07 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andre Hedrick <andre@linux-ide.org>
cc: Mukesh Rajan <mrajan@ics.uci.edu>, <linux-kernel@vger.kernel.org>,
       <mlord@pobox.com>
Subject: Re: IDE, putting HD to sleep causes "lost interrupt"
In-Reply-To: <Pine.LNX.4.10.10207310958520.25961-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0208011348020.5119-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 31 Jul 2002, Andre Hedrick wrote:
> Because you need to call
> 
> hdparm -w /dev/hda		<--- Reset Device
> hdparm -C /dev/hda		<--- query status, repeat until good.
> hdparm -X** /dev/hda		<--- transfer rate mode set
> hdparm -m** /dev/hda		<--- set multiple
> hdparm -d* /dev/hda		<--- set DMA
> 
> You effectively kill (disable command mode) the drive has to be kick
> started.

Well, mind how horribly that sucks if your hdparm is on the disk you've 
sent to sleep. Thus, never send your disk containing /sbin to sleep...

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

