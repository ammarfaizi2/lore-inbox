Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131444AbRCNPuJ>; Wed, 14 Mar 2001 10:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRCNPt7>; Wed, 14 Mar 2001 10:49:59 -0500
Received: from s057.dhcp212-109.cybercable.fr ([212.198.109.57]:23556 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131444AbRCNPtj>; Wed, 14 Mar 2001 10:49:39 -0500
Message-ID: <3AAF929E.7D1F2F05@baretta.com>
Date: Wed, 14 Mar 2001 16:47:42 +0100
From: Alex Baretta <alex@baretta.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 5Mb missing...
In-Reply-To: <Pine.LNX.4.33.0103070958110.1424-100000@mikeg.weiden.de> <l03130302b6d530a44df8@[192.168.239.101]> <3AAF977D.DE602385@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Jonathan Morton wrote:
> >
> > The kernel itself takes up some RAM, which is simply subtracted from the
> > "total memory available" field in the memory summaries available to
> > user-mode processes.  This is perfectly normal.
> 
> The kernel reserves 4m for hilself. The off by one error is a rounding
> bug.

Sounds pretty reasonable. I have actually tested the memory card
with memtest, just to make sure that it was all there and working
properly, and the test succeeded, so it must really be the kernel
eating away a few megs.

Alex
