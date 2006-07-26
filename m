Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWGZWKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWGZWKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 18:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWGZWKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 18:10:05 -0400
Received: from lucidpixels.com ([66.45.37.187]:14298 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030311AbWGZWKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 18:10:04 -0400
Date: Wed, 26 Jul 2006 18:10:02 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: adam radford <aradford@gmail.com>
cc: dean gaudet <dean@arctic.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: 3ware disk latency?
In-Reply-To: <b1bc6a000607261507g663ad95cwcc4a2ae4622e0fa2@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607261809350.6441@p34.internal.lan>
References: <20060710141315.GA5753@fi.muni.cz> 
 <Pine.LNX.4.64.0607260942110.22242@twinlark.arctic.org> 
 <1153946249.13509.29.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0607261440470.4568@twinlark.arctic.org>
 <b1bc6a000607261507g663ad95cwcc4a2ae4622e0fa2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Jul 2006, adam radford wrote:

> On 7/26/06, dean gaudet <dean@arctic.org> wrote:
>> 
>> unfortunately when i did the experiment i neglected to perform
>> simultaneous tests on more than one 3ware unit on the same controller.  i
>> got great results from a raid1 or from a raid10 (even a raid5)... but
>> never i only tested one unit at a time.
>> 
>
> Did you try setting /sys/class/scsi_host/hostX/cmd_per_lun to 256 / num_units 
> ?
>
> -Adam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Speaking of this does anyone having any tuning guides for running 10 disk 
raid 5's on this controller? And as far as ext3 goes, what are the best 
optimizations?

