Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267876AbTBEJFC>; Wed, 5 Feb 2003 04:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267877AbTBEJFB>; Wed, 5 Feb 2003 04:05:01 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:19212 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267876AbTBEJFB>; Wed, 5 Feb 2003 04:05:01 -0500
Message-Id: <200302050905.h1595Qs17144@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Thomas =?koi8-r?q?B=3Ftzler?= <t.baetzler@bringe.com>,
       linux-kernel@vger.kernel.org
Subject: Re: filesystem access slowing system to a crawl
Date: Wed, 5 Feb 2003 11:03:41 +0200
X-Mailer: KMail [version 1.3.2]
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
In-Reply-To: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 February 2003 11:29, Thomas B?tzler wrote:
> maybe you could help me out with a really weird problem we're having
> with a NFS fileserver for a couple of webservers:
>
> - Dual Xeon 2.2 GHz
> - 6 GB RAM
> - QLogic FCAL Host adapter with about 5.5 TB on a several RAIDs
> - Debian "woody" w/Kernel 2.4.19
>
> Running just "find /" (or ls -R or tar on a large directory) locally
> slows the box down to absolute unresponsiveness - it takes minutes
> to just run ps and kill the find process. During that time, kupdated
> and kswapd gobble up all available CPU time.
>
> The system performs great otherwise, so I've ruled out a hardware
> problem. It can't be a load problem because during normal operation,
> the system is more or less bored out of its mind (70-90% idle time).
>
> I'm really at the end of my wits here :-(
>
> Any help would be greatly appreciated!

Canned response: 
* does non-highmem kernel make any difference?
* does UP kernel make any difference?
* can you profile kernel while "time ls -R" is running?
* try 2.4.20 and/or .21-pre4
* tell us what you found out
--
vda
