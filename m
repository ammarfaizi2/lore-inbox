Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbSIZHWj>; Thu, 26 Sep 2002 03:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262231AbSIZHWj>; Thu, 26 Sep 2002 03:22:39 -0400
Received: from packet.digeo.com ([12.110.80.53]:34267 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262230AbSIZHWi>;
	Thu, 26 Sep 2002 03:22:38 -0400
Message-ID: <3D92B6F3.1428A76A@digeo.com>
Date: Thu, 26 Sep 2002 00:27:47 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
CC: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.19pre10aa4 OOPS in ext3 (get_hash_table, 
 unmap_underlying_metadata)
References: <3D92A1D0.5000203@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 07:27:48.0312 (UTC) FILETIME=[36DC8D80:01C2652E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:
> 
> Hiya,
> 
> Been having frequent (every 4-8 days) oopses with 2.4.19pre10aa4 on
> a moderately loaded server (100 users - 0.4 load avg).
> 
> The server is a Intel STL2 with dual P3, 1GB RAM, Intel Pro1000T
> and Qlogic 2300 Fibre channel HBA.
> 
> We are running qla2300, e1000 and lvm modules unmodified as present in
> 2.4.19pre10aa4. We also have quotas enabled on 1 of the ext3 fs.
> 

It's not familiar, sorry.

People are saying unkind things about the qlogic driver, and
the new version in Andrea's latest patchset is definitely
faster than before.   Might be worth a shot.
