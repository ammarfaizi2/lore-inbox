Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285732AbRLTArj>; Wed, 19 Dec 2001 19:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbRLTAr3>; Wed, 19 Dec 2001 19:47:29 -0500
Received: from c007-h012.c007.snv.cp.net ([209.228.33.219]:12464 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S285724AbRLTArS>;
	Wed, 19 Dec 2001 19:47:18 -0500
X-Sent: 20 Dec 2001 00:47:11 GMT
Message-ID: <3C21350F.64374FA4@bigfoot.com>
Date: Wed, 19 Dec 2001 16:47:11 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jean-Francois Levesque <jfl@jfworld.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: UDMA problem with Maxtor 7200rpm disk
In-Reply-To: <20011219151636.50e930ac.jfl@jfworld.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a problem regarding my new Asus A7V266 board with VIA KT266 chipset.  Byron Stanoszek told me to ask my problem to this list so here it is :
> 
> My hard drive is a Maxtor 5T030H3 ATA DISK drive (30 gig).  The problem is that I'm not able to read more than 7 MB/sec :
>
> ...
>
> I also have some idebus errors.

[dmesg output clipped]

1. Remove the AudioPCI card, recheck.
2. Check jumpers on CD, s/b set to Master.

AudioPCI and some VIA chipsets don't play well together.

rgds,
tim.

--
