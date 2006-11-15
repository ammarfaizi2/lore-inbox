Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030640AbWKOR4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030640AbWKOR4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030774AbWKOR4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:56:45 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:4163 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030640AbWKOR4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:56:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sfyZoS/cEv9Cmo2MKSghlxZF2eFnWdNHq2StZCbw2Gn7NZkL9mRbmWQO7a51wRHrPGDlG8ulAzt0Rkz9XiOM0GyMZ1oXvtSBeuo7jA7prBJGcZQR8ZZyg8pf4y5YzptP6GZMd44VRQPvQc2sFeDa7GHmd1Iqhf/s2zeCIZF0lgc=
Message-ID: <40f323d00611150956q7c61bcafqed43598c8c94fa65@mail.gmail.com>
Date: Wed, 15 Nov 2006 18:56:43 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: tglx@linutronix.de
Subject: Re: 2.6.19-rc5-mm2 -- 3d slow with dynticks
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1163586665.8335.334.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <40f323d00611141456i7d538593vaf7e962121b6009d@mail.gmail.com>
	 <1163586665.8335.334.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 2006-11-14 at 23:56 +0100, Benoit Boissinot wrote:
> > On 11/14/06, Andrew Morton <akpm@osdl.org> wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/
> > >
> >
> > CONFIG_NO_HZ=y still gives me slow 3d games on this one whereas
> > 2.6.19-rc5-mm1 +
> > http://tglx.de/private/tglx/2.6.19-rc5-mm1-dyntick.diff was fine.
> >
> > Maybe some patches where not merged ?
>
> I just checked. They are all in -mm2.
>
I just noticed I had no direct rendering and there was some acpi
errors in dmesg.

Doing a reboot solved it.

Sorry for the false alarm.

regards,

Benoit
