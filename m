Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278642AbRKHV5T>; Thu, 8 Nov 2001 16:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278633AbRKHV5J>; Thu, 8 Nov 2001 16:57:09 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:61714 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S278642AbRKHV5A>; Thu, 8 Nov 2001 16:57:00 -0500
Message-Id: <200111082156.fA8LuuY66000@aslan.scsiguy.com>
To: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@online.fr>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: Adaptec AIC7xxx support 
In-Reply-To: Your message of "Thu, 08 Nov 2001 22:45:58 +0100."
             <20011108224558.C505@online.fr> 
Date: Thu, 08 Nov 2001 14:56:56 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >This is a drawback of single driver for multiple cards. Good cards
>> >suffer to enable the driver to support bad ones.
>>=20
>> This has nothing to do with the card the aic7xxx driver is accessing.
>
>Sorry if I upset you.

You didn't upset me.  I just wanted to ensure that an inacurate statement
wasn't propogated.

>I was convinced it was to support old hardware.

Yes and no.  Although more common in older hardware, there are still
companies that bring new products to market that take *forever* to
wakeup after a bus reset.

>You seems to indicate that it depends more on the attached scsi targets,
>and I believe it but I have never seen this kind of configuration where
>the timeout needs to be 15000 Msec. Is this a so common config to set
>this value as default ?

There are still lots of devices out there that don't work with shorter
timeouts.  I don't know that it matters what percentage of people have
these devices so much as allowing them to install/use the OS without
the frustration of trying to figure out how to make their system work.
Other than a bit of wall clock time, the extra delay does not "hurt"
setups that can use a lower timeout.

--
Justin
