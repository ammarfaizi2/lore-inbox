Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSKOA5q>; Thu, 14 Nov 2002 19:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265426AbSKOA5q>; Thu, 14 Nov 2002 19:57:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:51945 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261836AbSKOA5p>;
	Thu, 14 Nov 2002 19:57:45 -0500
Message-ID: <3DD4481F.72627800@digeo.com>
Date: Thu, 14 Nov 2002 17:04:31 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       rl@hellgate.ch, linux-kernel@vger.kernel.org,
       Mikael Pettersson <mikpe@csd.uu.se>, mingo@redhat.com
Subject: Re: Yet another IO-APIC problem (was Re: via-rhine weirdness with 
 viakt8235 Southbridge)
References: <20021115002822.G6981@pc9391.uni-regensburg.de> <20021115011738.D17058@pc9391.uni-regensburg.de> <3DD445EF.9080002@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 01:04:31.0779 (UTC) FILETIME=[F4839730:01C28C42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> ...
> IMO we should just take out UP IOAPIC support in the kernel, or put a
> big fat warning in the kernel config _and_ at boot...
> 

It would be nice to get it working, because oprofile needs it.

(Well, oprofile can use the rtc, but then it doesn't profile
ints-off code)
