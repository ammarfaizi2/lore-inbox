Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbSLKXCF>; Wed, 11 Dec 2002 18:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbSLKXCF>; Wed, 11 Dec 2002 18:02:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:14822 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267353AbSLKXCD>;
	Wed, 11 Dec 2002 18:02:03 -0500
Message-ID: <3DF7C5B2.D9E0249C@digeo.com>
Date: Wed, 11 Dec 2002 15:09:38 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Roussey <sroussey@network54.com>
CC: robm@fastmail.fm, linux-kernel@vger.kernel.org
Subject: Re: Strange load spikes on 2.4.19 kernel
References: <000b01c2a168$37e747d0$026fa8c0@wehohome>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2002 23:09:38.0521 (UTC) FILETIME=[60F72490:01C2A16A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Roussey wrote:
> 
> Was there ever a solution to this issue?

No.  It wasn't clear what was going on.

>  Is it kernel or ext3 based issue?

One of those.

> Is there a workaround?

Tried mounting all filesystems `-o noatime'?

> I've spent two months looking for a source and
> solution to this issue. It is pressing for me since all our users get locked
> out at the height of the spike. Ours is a webserver.
> 

Is there much disk write activity?  What journalling mode
are you using?

The output of `ps aux' during a stall would be interesting,
as would the `vmstat 1' ouptut.
