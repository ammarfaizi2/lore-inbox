Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265617AbSKFGOS>; Wed, 6 Nov 2002 01:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265625AbSKFGOS>; Wed, 6 Nov 2002 01:14:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:48046 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265617AbSKFGOS>;
	Wed, 6 Nov 2002 01:14:18 -0500
Message-ID: <3DC8B4C0.4F8AD104@digeo.com>
Date: Tue, 05 Nov 2002 22:20:48 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lev Makhlis <mlev@despammed.com>, linux-kernel@vger.kernel.org,
       ricklind@us.ibm.com
Subject: Re: [PATCH] 2.5.46: overflow in disk stats
References: <200211060009.51684.mlev@despammed.com> <3DC8B16E.EAFC854@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 06:20:48.0899 (UTC) FILETIME=[A60A8D30:01C2855C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Why don't we just do
> 
>         return (x / HZ) * 1000;
> 

Well that was pretty stupid.  Ignore me.  You probably already
have.  Let's do it your way.
