Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbSKLTWh>; Tue, 12 Nov 2002 14:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266760AbSKLTWh>; Tue, 12 Nov 2002 14:22:37 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:47622 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S266731AbSKLTWh>; Tue, 12 Nov 2002 14:22:37 -0500
Message-Id: <200211121923.gACJNap10779@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@digeo.com>, alan@cotse.com
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
Date: Tue, 12 Nov 2002 22:14:59 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, vs@namesys.com
References: <3DD01B32.4A113A71@digeo.com> <YWxhbg==.563e560fc9743df6e2cd56ac2568e2c0@1037049066.cotse.net> <3DD021D3.B7F1C511@digeo.com>
In-Reply-To: <3DD021D3.B7F1C511@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 November 2002 19:32, Andrew Morton wrote:
> That sucker really works.  I run my desktop machines (768M and 256M)
> at swappiness=80% or 90%.   I end up with 10-20 megs in swap after a
> day or two, which seems about right.  The default of 60 is probably a
> little too unswappy.

I think swappiness should depend also on mem/disk latency ratio.
Imagine you have 32Gb IDE 'disk' made internally of tons of DRAM chips
(such things exist). I suppose you would like to swap more to it,
since access times are not ~10 ms, they are more like 10 us.

Hand tuning for optimal performance is doomed to be periodically
obsoleted by technology jumps. Today RAM is 1000000 times faster
than mass storage. Nobody knows what will happen in five years.
--
vda
