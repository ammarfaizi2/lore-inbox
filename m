Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313769AbSDPQyS>; Tue, 16 Apr 2002 12:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313770AbSDPQyR>; Tue, 16 Apr 2002 12:54:17 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:16399 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313769AbSDPQyR>;
	Tue, 16 Apr 2002 12:54:17 -0400
Date: Tue, 16 Apr 2002 08:53:35 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        sailer@ife.ee.ethz.ch, bhards@bigpond.net.au, torvalds@transmeta.com
Subject: Re: [PATCH] USB set-bit takes a long tweaks
Message-ID: <20020416155334.GD27287@kroah.com>
In-Reply-To: <E16xP4X-0005OC-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 19 Mar 2002 13:17:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 07:16:01PM +1000, Rusty Russell wrote:
> This removes gratuitous & operators in front of USB's
> dev->bus->devmap.devicemap and state->unitbitmap, for bitops.
> 
> This just makes it so it doesn't warn when set_bit et. al take a
> long...
> 
> No object code changes,

Thanks, I've applied this to my trees, and will include it in the next
round of changesets to Linus.


greg k-h
