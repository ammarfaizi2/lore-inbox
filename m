Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264718AbSJUDeh>; Sun, 20 Oct 2002 23:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264719AbSJUDeh>; Sun, 20 Oct 2002 23:34:37 -0400
Received: from packet.digeo.com ([12.110.80.53]:33791 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264718AbSJUDeh>;
	Sun, 20 Oct 2002 23:34:37 -0400
Message-ID: <3DB37734.434F1678@digeo.com>
Date: Sun, 20 Oct 2002 20:40:36 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: patch management scripts
References: <3DB30283.5CEEE032@digeo.com> <20021021023546.GK26443@waste.org> <3DB36C70.DFB52831@digeo.com> <20021021033033.GL26443@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2002 03:40:36.0570 (UTC) FILETIME=[9E098BA0:01C278B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> ...
> > - make changes to a not-topmost patch without having to do
> >   anything special.
> 
> Unless of course you're touching that file somewhere else in the
> stack.

No, that's OK.  I do this fairly regularly.  It tends to be the
case that the change you make causes the correct patch to throw
a reject when you try to take it off, so you remember to refresh
it.
