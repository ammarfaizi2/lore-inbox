Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbSJPQXu>; Wed, 16 Oct 2002 12:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265164AbSJPQXu>; Wed, 16 Oct 2002 12:23:50 -0400
Received: from packet.digeo.com ([12.110.80.53]:36736 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265154AbSJPQXs>;
	Wed, 16 Oct 2002 12:23:48 -0400
Message-ID: <3DAD93F2.510AF61@digeo.com>
Date: Wed, 16 Oct 2002 09:29:38 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Bernstein <matt@theBachChoir.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: oops (Re: 2.5.43-mm1)
References: <3DAD0F3D.39E5B5DC@digeo.com> <Pine.LNX.4.44.0210161212520.11594-100000@nick.dcs.qmul.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 16:29:38.0659 (UTC) FILETIME=[38CCD330:01C27531]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Bernstein wrote:
> 
> My SMP highmem Athlon did the following (further details on request):
> 
> kernel BUG at arch/i386/mm/highmem.c:40!

Yup, thanks.  I think we'll separate the shared pagetables patches
out for a little while.
