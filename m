Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264676AbSJOUSY>; Tue, 15 Oct 2002 16:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264684AbSJOUSY>; Tue, 15 Oct 2002 16:18:24 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:46735 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S264676AbSJOUSX>; Tue, 15 Oct 2002 16:18:23 -0400
Message-Id: <5.1.0.14.2.20021015131839.01c1a008@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 15 Oct 2002 13:23:28 -0700
To: "David S. Miller" <davem@redhat.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [RFC] Rename _bh to _softirq
Cc: kuznet@ms2.inr.ac.ru, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20021015.124204.108190832.davem@redhat.com>
References: <5.1.0.14.2.20021015121958.01b4acd8@mail1.qualcomm.com>
 <5.1.0.14.2.20021015093146.05eb7738@mail1.qualcomm.com>
 <20021015.104423.36363214.davem@redhat.com>
 <5.1.0.14.2.20021015121958.01b4acd8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:42 PM 10/15/2002 -0700, David S. Miller wrote:
>    From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
>    Date: Tue, 15 Oct 2002 12:24:18 -0700
>
>    We don't give names to a functions based on the coolness, do we ?
>    ;-)
>
>cli() was cool too.
But we did rename it.

>Just because you don't see that a base handler really is an
>alias for softirq these days, doesn't mean we should delete it.
Dave, you just confirmed that _bh is indeed confusing. And some
people don't even know what it is ;-).
_bh is not a "base handler" it stands for "bottom half".

Max





