Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSLZHkI>; Thu, 26 Dec 2002 02:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSLZHkI>; Thu, 26 Dec 2002 02:40:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:16300 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262620AbSLZHkI>;
	Thu, 26 Dec 2002 02:40:08 -0500
Message-ID: <3E0AB440.61DCA481@digeo.com>
Date: Wed, 25 Dec 2002 23:48:16 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aniruddha M Marathe <aniruddha.marathe@wipro.com>
CC: linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>
Subject: Re: [BENCHMARK] lmbench results for 5.53 mm1
References: <94F20261551DC141B6B559DC49108672044279@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Dec 2002 07:48:16.0506 (UTC) FILETIME=[268355A0:01C2ACB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniruddha M Marathe wrote:
> 
> 1. increase in time for fork proc       415             382
> 2. increase in time for sh proc         8190            8088

pagetable sharing adds a little overhead to fork and exec in
microbenchmarks.  You should state whether it was enabled.
