Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131193AbRCGXXj>; Wed, 7 Mar 2001 18:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131198AbRCGXXa>; Wed, 7 Mar 2001 18:23:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5903 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131193AbRCGXXT>;
	Wed, 7 Mar 2001 18:23:19 -0500
Date: Thu, 8 Mar 2001 00:22:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: Derek Fawcus <dfawcus@cisco.com>, linux-kernel@vger.kernel.org
Subject: Re: can't read DVD (under 2.4.[12] & 2.2.17)
Message-ID: <20010308002251.V4653@suse.de>
In-Reply-To: <20010307232637.T4653@suse.de> <Pine.GSO.4.30.0103072355310.6363-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0103072355310.6363-100000@balu>; from pozsy@sch.bme.hu on Wed, Mar 07, 2001 at 11:58:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07 2001, Pozsar Balazs wrote:
> 
> Adding the
>  cgc.buflen = 20;
> line into drivers/cdrom/cdrom.c: dvd_read_physical(...)
> solves my problem.
> 
> I don't know the difference, but first you mentioned
>  cgc.buflen = 16;
> so i tried that also, and it worked the same.
> 
> I'll write again if i'm having problems. :)
> Thanks for the fast patch.

Great, it worked out in the end :-)

> I think you should also check 2.2.

Definitely, 2.2 and 2.4 are 100% similar in this regard.

-- 
Jens Axboe

