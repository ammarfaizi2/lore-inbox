Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSFOVT6>; Sat, 15 Jun 2002 17:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSFOVT5>; Sat, 15 Jun 2002 17:19:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315593AbSFOVT5>;
	Sat, 15 Jun 2002 17:19:57 -0400
Message-ID: <3D0BB065.317E8027@zip.com.au>
Date: Sat, 15 Jun 2002 14:23:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <20020615210009.GA32730@rushmore>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
> 
> > Does this patch get the throughput back?
> 
> That makes all the difference to dbench.  Throughput
> for dbench 128 up over 40% compared to vanilla 2.5.21.

ho hum.  Now we need to work out why a larger request queue
whacks dbench, whether it penalises workloads which we actually
care about and if so, what the appropriate size really should be.
If indeed that algorithms are optimal.  urgh.

Thanks again, Randy.

-
