Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264734AbSJOQ2e>; Tue, 15 Oct 2002 12:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264735AbSJOQ2b>; Tue, 15 Oct 2002 12:28:31 -0400
Received: from [129.46.51.58] ([129.46.51.58]:47595 "EHLO numenor.qualcomm.com")
	by vger.kernel.org with ESMTP id <S264734AbSJOQ22>;
	Tue, 15 Oct 2002 12:28:28 -0400
Message-Id: <5.1.0.14.2.20021015093146.05eb7738@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 15 Oct 2002 09:34:02 -0700
To: kuznet@ms2.inr.ac.ru, mingo@elte.hu
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [RFC] Rename _bh to _softirq
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210150157.FAA13254@sex.inr.ac.ru>
References: <Pine.LNX.4.44.0210142119300.26635-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:57 AM 10/15/2002 +0400, kuznet@ms2.inr.ac.ru wrote:
>Hello!
>
> >         But yes, i agree, and there are a number of other
> > renames that would make perfect sense.
>
>Oh, do you dislike names with history? I love them. :-)
>Well, bh is short, looks nice and cryptic enough.
>
>After true BHs have gone, just say that "bh" is alias for "softirq".
Sure. Just like I said we can keep compatibility defines
         #define local_bh_disable local_softirq_disable

But primary interface should be changed IMO.

Max


