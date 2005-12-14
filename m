Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbVLNCCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVLNCCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbVLNCCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:02:47 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:9660 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030351AbVLNCCq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:02:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MR6son7rdgiWfMorqPBkkDmP8HsBVwBl5br/FtSNu0bz4pvxz5GjbWG8xLQ4EpaIpH3mP4T0mMG6Gwja+L7NLFG6AUpCbubvpzweEv98ya7YZTqAkFtLmB4Jev6+ImYZDAQTIFomCb35uf7f8mo4PfpKbtU1sipKOxnIpuJVrAk=
Message-ID: <c775eb9b0512131802i386bfa7cu4d2e2c3d4d598069@mail.gmail.com>
Date: Wed, 14 Dec 2005 07:32:44 +0530
From: Bharath Ramesh <krosswindz@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Only one processor detected in 8-Way opteron in 32-bit mode
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <4396036C.70107@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>
	 <c775eb9b0512011651kb0e1cb4xf79ca20372f6d76e@mail.gmail.com>
	 <c775eb9b0512011712x2f4f2f44t4cd11d5d6f60a9d8@mail.gmail.com>
	 <a762e240512011742p681df3bdic16598a85926dd67@mail.gmail.com>
	 <c775eb9b0512020732v3f41f91fpb3b4b61b0b539d92@mail.gmail.com>
	 <a762e240512021407p5a31c0daid902352625701ca2@mail.gmail.com>
	 <c775eb9b0512021534y693f3bf3i4b85b7cb0dcb08b6@mail.gmail.com>
	 <a762e240512021701q4ea436d9u563704c4daeb7584@mail.gmail.com>
	 <c775eb9b0512021806wb8bb3fdh9cd0a0a80fead69@mail.gmail.com>
	 <4396036C.70107@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Bill Davidsen <davidsen@tmr.com> wrote:
> Bharath Ramesh wrote:
> > I have attached the kernel config. I will enable debugging and rebuild
> > the kernel soon and send in the latest dmesg soon.
> >
> > Thanks,
> >
> > Bharath
>
> I'm not at all an expert on x86_64, but I notice the NUMA is not set in
> this config, and I have a similar config from another post with DOES
> work, and it has NUMA on (four way only, dual dual-core).

I am not sure about it but the NUMA option comes up only when the ARCH
type is set to x86_64. For some reason when I set the ARCH type to x86
then the NUMA option is never present. NUMA is only associated with
x86_64 but I am not sure how it would work if I am trying to run
x86_64 processor in x86 mode.

>
> I have no idea if that can be useful, but if you're still out of ideas
> you might try it.
>
> --
>    -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
>  last possible moment - but no longer"  -me
>
>
