Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267211AbSKSStR>; Tue, 19 Nov 2002 13:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbSKSSsl>; Tue, 19 Nov 2002 13:48:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:4342 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267211AbSKSSrw>;
	Tue, 19 Nov 2002 13:47:52 -0500
Message-ID: <3DDA88F9.41F41CB9@digeo.com>
Date: Tue, 19 Nov 2002 10:54:49 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alessandro Suardi <alessandro.suardi@oracle.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Oracle 9.2 OOMs again at startup in 2.5.4[78]
References: <3DDA4921.30403@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Nov 2002 18:54:50.0009 (UTC) FILETIME=[2336D890:01C28FFD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> 
> ...just like it did a few kernels ago (the current->mm issue in 2.5.19
>   that eventually got fixed in 2.5.30 or thereabouts, introduced for the
>   bk-enabled by cset 1.373.221.1).

According to the web interface, 1.373.221.1 is 

"This patch lets more devices hook up to USB 2.0 hubs, stuff
like keyboards, mice, hubs that hasn't worked yet"

so, errr.

> I'll go building a 2.5.44 kernel (think it's the only one I didn't have
>   too much trouble building / booting in the 2.5.4x series before .47)
>   and see whether it works or not.

An `strace -f' of the startup process might reveal something.
