Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262136AbSJNT7l>; Mon, 14 Oct 2002 15:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262150AbSJNT7k>; Mon, 14 Oct 2002 15:59:40 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:21639 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262136AbSJNT7j>; Mon, 14 Oct 2002 15:59:39 -0400
Message-Id: <5.1.0.14.2.20021014125856.08435570@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 Oct 2002 13:05:26 -0700
To: Jeff Garzik <jgarzik@pobox.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [RFC] Rename _bh to _softirq
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DAB1738.2030706@pobox.com>
References: <5.1.0.14.2.20021014115238.084140f8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:12 PM 10/14/2002 -0400, Jeff Garzik wrote:
>Maksim (Max) Krasnyanskiy wrote:
>>Hi Folks,
>>Old BHs have been almost completely replaced with tasklets and softirqs.
>
>In 2.5?  They have been replaced by work queues...
>though in some cases manual conversion to tasklets is more appropriate.
Task queues were replaced with work queues. I'm taking about things like 
NET_BH, TIMER_BH, etc.
In general what's been called "bottom half" is now referred to as "softirq".

Max


