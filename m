Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbTCNWnx>; Fri, 14 Mar 2003 17:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261211AbTCNWnx>; Fri, 14 Mar 2003 17:43:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:23177 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261191AbTCNWnw>;
	Fri, 14 Mar 2003 17:43:52 -0500
Date: Fri, 14 Mar 2003 14:49:11 -0800
From: Andrew Morton <akpm@digeo.com>
To: Rob Funk <rfunk@funknet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre5 oops in mod_timer
Message-Id: <20030314144911.5466923e.akpm@digeo.com>
In-Reply-To: <20030314192121.GA6395@marvin.local.funknet.net>
References: <20030314192121.GA6395@marvin.local.funknet.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 22:54:34.0628 (UTC) FILETIME=[AE9EC440:01C2EA7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Funk <rfunk@funknet.net> wrote:
>
> 2.4.21-pre5 has been the most stable 2.4.21-pre yet for me (I haven't
> tried the pre5-ac patches though), but after a week of uptime I got
> this oops...
>
> ...
> Unable to handle kernel paging request at virtual address 02000004
> ...
> eax: 00000000   ebx: d9ec333c   ecx: 00000000   edx: 02000000

Single-bit error in a list_head member.  Hardware problem.  Run memtest86
for >24 hours, 
