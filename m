Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265345AbSJXILW>; Thu, 24 Oct 2002 04:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265346AbSJXILW>; Thu, 24 Oct 2002 04:11:22 -0400
Received: from packet.digeo.com ([12.110.80.53]:34047 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265345AbSJXILW>;
	Thu, 24 Oct 2002 04:11:22 -0400
Message-ID: <3DB7AC97.D31A3CB2@digeo.com>
Date: Thu, 24 Oct 2002 01:17:27 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [long]2.5.44-mm3 UP went into unexpected trashing
References: <3DB7A581.9214EFCC@aitel.hist.no> <3DB7A80C.7D13C750@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2002 08:17:28.0157 (UTC) FILETIME=[CA8DD0D0:01C27B35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Hopefully the rcu fix in -mm4 will cure this.

Oh.  It was in -mm3 too.  But something went wrong with the
dcache shrinking there.
