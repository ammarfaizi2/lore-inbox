Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWHWP7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWHWP7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWHWP7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:59:08 -0400
Received: from lucidpixels.com ([66.45.37.187]:45018 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S965019AbWHWP7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:59:07 -0400
Date: Wed, 23 Aug 2006 11:59:06 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Johan Groth <johan.groth@linux-grotto.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Scsi errors with Megaraid 300-8x
In-Reply-To: <44EC7AFD.2070605@linux-grotto.org.uk>
Message-ID: <Pine.LNX.4.64.0608231158210.15031@p34.internal.lan>
References: <44EB1875.3020403@linux-grotto.org.uk> <44EC73D2.9090302@rtr.ca>
 <44EC775C.7040003@linux-grotto.org.uk> <Pine.LNX.4.64.0608231145290.15031@p34.internal.lan>
 <44EC78CD.9010401@linux-grotto.org.uk> <Pine.LNX.4.64.0608231153130.15031@p34.internal.lan>
 <44EC7AFD.2070605@linux-grotto.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Aug 2006, Johan Groth wrote:

> Justin Piszcz wrote:
>> 
>> Nope, r+w will write over everything on the disk, but I have found -the- 
>> most effective way to see if a disk is good or not.  I'd rather have the 
>> disk die to that test rather than using it in production and finding it 
>> dies with my data on it.
>> 
>
> Hmm, we both should read the man page of badblocks a bit better :).
> I found this:
>
> -n     Use non-destructive read-write mode.  By default only a 
> non-destructive read-only test is done. This option must not be combined with 
> the -w option, as they are mutually exclusive.
>
>
> Cheers,
> Johan
>

I have not tested that option.  I wonder if it is as good as a real R+W 
mode.  What does smartctl -a /dev/sda say on the disk that you are having 
problems with?
