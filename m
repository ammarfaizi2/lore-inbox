Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWHWPx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWHWPx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWHWPx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:53:57 -0400
Received: from lucidpixels.com ([66.45.37.187]:5566 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S964998AbWHWPx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:53:56 -0400
Date: Wed, 23 Aug 2006 11:53:55 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Johan Groth <johan.groth@linux-grotto.org.uk>
cc: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Scsi errors with Megaraid 300-8x
In-Reply-To: <44EC78CD.9010401@linux-grotto.org.uk>
Message-ID: <Pine.LNX.4.64.0608231153130.15031@p34.internal.lan>
References: <44EB1875.3020403@linux-grotto.org.uk> <44EC73D2.9090302@rtr.ca>
 <44EC775C.7040003@linux-grotto.org.uk> <Pine.LNX.4.64.0608231145290.15031@p34.internal.lan>
 <44EC78CD.9010401@linux-grotto.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Aug 2006, Johan Groth wrote:

> Justin Piszcz wrote:
>> Run badblocks in r+w mode on the bad disk and it will force the disk to 
>> re-allocate the bad sector if it can.
>> 
>> Justin.
>
> Is that possible to do in a non-destructive way? I don't want to loose all 
> data and apparently I can't back it up either :(.
>
> Regards,
> Johan
>

Nope, r+w will write over everything on the disk, but I have found -the- 
most effective way to see if a disk is good or not.  I'd rather have the 
disk die to that test rather than using it in production and finding it 
dies with my data on it.

Justin.
