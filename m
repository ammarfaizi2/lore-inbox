Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319051AbSIJGjh>; Tue, 10 Sep 2002 02:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319053AbSIJGjg>; Tue, 10 Sep 2002 02:39:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10711 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319051AbSIJGjf>;
	Tue, 10 Sep 2002 02:39:35 -0400
Date: Tue, 10 Sep 2002 08:43:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@digeo.com>, Jesse Barnes <jbarnes@sgi.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "'David S. Miller'" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
Message-ID: <20020910064354.GM8719@suse.de>
References: <019f01c25826$c553f310$9e10a8c0@IMRANPC> <E17oTES-0006qj-00@starship> <3D7CF93A.972FCC8D@digeo.com> <E17oVLe-0006uT-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17oVLe-0006uT-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09 2002, Daniel Phillips wrote:
> On Monday 09 September 2002 21:40, Andrew Morton wrote:
> > We need a general-purpose "read or write these pages to this blockdev"
> > library function.
> 
> I thought bio was supposed to be that.  In what way does it not suffice?
> Simply because of not having a suitable wrapper?

a bio _can_ hold a number of pages, it's just that noone has written the
bio_rw_pages() yet. Not that it would be hard...

-- 
Jens Axboe

