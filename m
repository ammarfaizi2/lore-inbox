Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSKMUbY>; Wed, 13 Nov 2002 15:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSKMUbY>; Wed, 13 Nov 2002 15:31:24 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:28553 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S263333AbSKMUbA>; Wed, 13 Nov 2002 15:31:00 -0500
Date: Wed, 13 Nov 2002 12:40:51 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug
To: Greg KH <greg@kroah.com>
Cc: rusty@rustcorp.com.au, kaos <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Message-id: <3DD2B8D3.6060106@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3DD2B1D5.7020903@pacbell.net> <20021113201710.GB7238@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Nov 13, 2002 at 12:11:01PM -0800, David Brownell wrote:
> 
>>The module-init-tools-0.6.tar.gz utilities (or something
>>related -- kbuild changes?) break hotplug since they no
>>longer produce the /lib/modules/$(uname -r)/modules.*map
>>files as output ... so the hotplug agents don't have the
>>pre-built database mapping device info to drivers.
> 
> 
> Last I heard, Rusty's still working on this.  He's also going to be
> changing the format so we don't expose kernel structures to userspace,
> which would be a good thing.

So long as the _information_ in those structures stays available, good.
And it'd be handy if the text format for that information didn't change;
how it's stored in object modules doesn't matter.


> In short, he knows this is a requirement, and shouldn't be broken for
> long.

Good, that's important.

- Dave


> thanks,
> 
> greg k-h
> 




