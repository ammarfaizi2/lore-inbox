Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265301AbUFIOFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUFIOFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 10:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUFIOFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 10:05:19 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:44726 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265301AbUFIOFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 10:05:09 -0400
Message-ID: <1156.128.150.143.219.1086789581.squirrel@webmail.seven4sky.com>
In-Reply-To: <200406090812.20041.norman.r.weathers@conocophillips.com>
References: <Pine.LNX.4.44.0406082058400.24569-100000@coffee.psychology.mcmaster.ca>
    <200406090812.20041.norman.r.weathers@conocophillips.com>
Date: Wed, 9 Jun 2004 09:59:41 -0400 (EDT)
Subject: Re: 2.4.26 SMP lockup problem
From: "Sam Gill" <samg@seven4sky.com>
To: norman.r.weathers@conocophillips.com
Cc: "Mark Hahn" <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Reply-To: samg@seven4sky.com
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would run a diff command on
the config from the working chipset, aginst the
current config you are trying to use.

If you have the wrong chipset/processor selected
it could cause you problems similar to the ones
you are having.


-Sam


>
>
> On Tuesday 08 June 2004 08:00 pm, Mark Hahn wrote:
>> > CONFIG_X86_LOCAL_APIC=y
>>
>> that's the first thing I'd try turning off...
>>
>
> I have it disabled on the lilo promptwith noapic.  If that is not enough
> to
> keep it disabled on these nodes, then I will turn it off completely.
>
>> > make), great as I have about 200 nodes right now that are candidates
>> for
>> > testing.
>>
>> heh.  I'm a cluster admin myself, much smaller now, but looking
>> at adding 512-768 duals by the end of the year.  gulp!
>
> Just went through that with a series of IBM blades.  Don't envy ya.
>
> --
>
> Norman Weathers
> SIP Linux Cluster
> TCE UNIX
> ConocoPhillips
> Houston, TX
>
> Office:  LO2003
> Phone:   ETN  639-2727
> 	 or (281) 293-2727
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

