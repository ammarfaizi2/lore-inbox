Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751005AbWFELrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWFELrY (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWFELrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:47:24 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:12247 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751005AbWFELrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:47:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hzYcJyZK8uc8EjKvI76Sc5YDbxBfziE5sCWbWf57N/yU3OYKmT1biT3SA/y7QICSndJ0EtH24DMFNdI+q0FdLrt6+oZ4FFwjblgoJK/zP2bhikHlUcV0kP19fdwt6EUCopFB2W34fcy2LrmKAI3bTtojMovCrgYFgLZr6jh8Rwk=
Message-ID: <beee72200606050447q49bdaed1m7b5ac54b51f564db@mail.gmail.com>
Date: Mon, 5 Jun 2006 13:47:23 +0200
From: "davor emard" <davoremard@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: SMP HT + USB2.0 crash
Cc: "Olaf Hering" <olh@suse.de>, "Con Kolivas" <kernel@kolivas.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <beee72200606042334l7f6b63e6jd2156d5dffb3da4b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <beee72200606040322w2960e5f9j1716addc39949ccb@mail.gmail.com>
	 <200606042142.01879.kernel@kolivas.org>
	 <beee72200606040729u4c660583g1b7e669b85db5bca@mail.gmail.com>
	 <20060604145420.GA26218@suse.de> <1149441021.30785.10.camel@mindpipe>
	 <beee72200606042334l7f6b63e6jd2156d5dffb3da4b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI

I downloaded memtest86 iso image and let it running. I passed
1st battery of tests and continues. I'm pretty sure it will keep
pass those test without anyerrors, after all memories there
are 2x512MB samsung and for this machine I was choosing
ram's recommended by the manufacturer this motherboard.

Regarding nvidia, I don't like their binary policy but I may
tell you that both intel 925XE machines can run indefinitely
(for days even months until I reinstall new kernel)
each with a lot of simultaneous openGL with nvidia on 2 monitors
in dual head, dvb receiving over usb (here I mean USB 1.1 only)
firewire traffic, SPDIF output, ethernet traffic on both interfaces
and all that
through enabled SMP, PREEMPT and PREEMPT BIG_KERNEL_LOCK
and it is not going to crash.

As soon as I enable EHCI there it comes.
Otherwise I have option to use EHCI and don't use SMP
but not them both.



On 6/5/06, davor emard <davoremard@gmail.com> wrote:
> HI
>
> Due to popular demand I'm mailing the recent crash
> captured with serial cable on 2.6.16.19 on intel 925X
> triggered with SMP + USB2.0 combination.
>
> Here we got it, it's pretty random and useless for
> tracking the real problem so please don't blame
> software demux in DVB core just becaise it randomly
> crashed there - only thing that matters is that a800
> terrestroal receiver was running in USB 2.0 mode in
> order to generate enough usb2.0 traffic
> to trigger SMP+EHCI bug.
>
> I contributed myself to the dvb software demux code
> and it runs stable with it's demux core part almost
> unchanged for 2 years.
>
> If I remove EHCI and run a800 in USB 1.1 mode everything
> can run stable for any amount of time.
>
>
