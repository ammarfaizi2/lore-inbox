Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319099AbSHFOkt>; Tue, 6 Aug 2002 10:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319102AbSHFOkt>; Tue, 6 Aug 2002 10:40:49 -0400
Received: from daimi.au.dk ([130.225.16.1]:31381 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S319099AbSHFOkr>;
	Tue, 6 Aug 2002 10:40:47 -0400
Message-ID: <3D4FE0B9.751A3E92@daimi.au.dk>
Date: Tue, 06 Aug 2002 16:44:09 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jakob Oestergaard <jakob@unthought.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Disk (block) write strangeness
References: <20020805184921.GC2671@unthought.net> <1028578632.18156.71.camel@irongate.swansea.linux.org.uk> <20020805190706.GD2671@unthought.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard wrote:
> 
> I'm *very* certain that Linux does this non-sequentially, because the
> disk might be causing the half-block oddity which really surprised me,
> but the disk is not caching 20 MB of data internally, for sure.

Maybe you shouldn't consider the powerfailure as a happening at one
single point in time, but rather happening during a short periode of
time. Maybe it is possible during this periode of time, that at some
times there is enough power for actually writing to the disk, and at
other times there is not.

I think it should be possible for the firmware on a good disk to
prevent such artifacts. But I think you can find disks that just
keeps trying to write even while power is failing.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
