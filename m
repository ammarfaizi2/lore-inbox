Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUHaSIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUHaSIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUHaSF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:05:59 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:51973 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S266115AbUHaSEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:04:46 -0400
Date: Tue, 31 Aug 2004 20:04:24 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Michael Thonke <MThonke@wayne-europe.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS v3.6 fails to mount root partiton not usable with 2.6.9- rc1-mm1
Message-ID: <20040831180424.GA1955@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <04Aug31.085934cest.332169@gateway.wayne-europe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04Aug31.085934cest.332169@gateway.wayne-europe.com>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Thonke <MThonke@wayne-europe.com>
Date: Tue, Aug 31, 2004 at 08:50:53AM +0200
> Hello,
> 
> I tried to boot my root partition (Softwareraid Stripeset) 
> with 2.6.9-rc1-mm1 kernel but on fsck.reiserfs
> the system stops working and compain about a unresolveable filesystem error
> which can't be corrected. I tried to do it manually but no success either.
> On start the dmesg output is nearly the same as the one from my old kernel.
> No errors while md0 and md1 initialized also the ReiserFS Superblock was
> found.
> So I went back to my 2.6.8.1 kernel and everything works perfectly.
> Does someone get the same error while using ReiserFS v3.6 with
> 2.6.9-rc1-mm1?
> 
> Please CC me while I'm not registred to the mailing list
> 
There is a bug that corrupts data in 2.6.9-rc1-mm1, try 2.6.9-rc1-mm2
please.

Jurriaan
-- 
When I leave I don't know what I'm hoping to find
When I leave I don't know what I'm leaving behind...
   Rush - The analog kid.
Debian (Unstable) GNU/Linux 2.6.9-rc1-mm1 2x6078 bogomips load 0.03
