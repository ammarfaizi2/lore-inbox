Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267455AbTAXBuq>; Thu, 23 Jan 2003 20:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267477AbTAXBuq>; Thu, 23 Jan 2003 20:50:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:11708 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267455AbTAXBuq>;
	Thu, 23 Jan 2003 20:50:46 -0500
Date: Thu, 23 Jan 2003 18:00:01 -0800
From: Andrew Morton <akpm@digeo.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: dmo@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org, markw@osdl.org,
       cliffw@osdl.org, maryedie@osdl.org, jenny@osdl.org
Subject: Re: [BUG] BUG_ON in I/O scheduler, bugme # 288
Message-Id: <20030123180001.426f165e.akpm@digeo.com>
In-Reply-To: <3E30990D.3090305@cyberone.com.au>
References: <20030123135448.A8801@acpi.pdx.osdl.net>
	<3E30990D.3090305@cyberone.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 01:59:40.0872 (UTC) FILETIME=[41CD9C80:01C2C34C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> I think this may be because
> deadline_add_drq_rb puts "aliased" requests in the next_drq although they
> are not put on the sort or fifo lists. This is the problem I described to
> you before and exists in mm4.

Yes, but 2.5.59 doesn't do that.


