Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbSKEXNe>; Tue, 5 Nov 2002 18:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbSKEXNd>; Tue, 5 Nov 2002 18:13:33 -0500
Received: from packet.digeo.com ([12.110.80.53]:5539 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265333AbSKEXNc>;
	Tue, 5 Nov 2002 18:13:32 -0500
Message-ID: <3DC8521F.47270896@digeo.com>
Date: Tue, 05 Nov 2002 15:19:59 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: 2.5.46: SCSI and/or ReiserFS v3.6 broken? Kernel panic
References: <200211060006.10425.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Nov 2002 23:19:59.0844 (UTC) FILETIME=[DC6E8240:01C28521]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> VFS: Cannot open root device "803" or 08:03
> Please append a correct "root=" boot option
> Kernel panic: VFS: unable to mount root fs on 08:03
> 

That was happening to me yesterday as well.  After a bit
of poking around and recompiling, it mysteriously went away.

The same has happened about ten times over the past few months,
and rebuilding the world makes it go away.  On ext3.

Something is definitely fishy.  It's unhelpful that it cures
itself just as you get geared up to fix it.

Does a full rebuild fix it for you?
