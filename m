Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264651AbSJOUZF>; Tue, 15 Oct 2002 16:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSJOUZF>; Tue, 15 Oct 2002 16:25:05 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:59526 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S264651AbSJOUY5>; Tue, 15 Oct 2002 16:24:57 -0400
Message-Id: <5.1.0.14.2.20021015132636.01bdab40@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 15 Oct 2002 13:30:03 -0700
To: Oliver Xymoron <oxymoron@waste.org>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [RFC] Rename _bh to _softirq
Cc: "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021015195535.GL4771@waste.org>
References: <5.1.0.14.2.20021015121958.01b4acd8@mail1.qualcomm.com>
 <5.1.0.14.2.20021015093146.05eb7738@mail1.qualcomm.com>
 <Pine.LNX.4.44.0210142119300.26635-100000@localhost.localdomain>
 <200210150157.FAA13254@sex.inr.ac.ru>
 <5.1.0.14.2.20021015093146.05eb7738@mail1.qualcomm.com>
 <5.1.0.14.2.20021015121958.01b4acd8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver,

> > >   But primary interface should be changed IMO.
> > >
> > >I totally disagree.
> > Care to explain why ?
> >
> > >Keep _bh, it's cool.
> > But pretty much meaningless.
>
>No, now it clearly means buffer head.
Another point in favor of renaming :).

local_bh_disable() disables local _softirqs_ not "local buffer head".

Max

