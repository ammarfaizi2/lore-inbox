Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSJWTfd>; Wed, 23 Oct 2002 15:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265170AbSJWTfd>; Wed, 23 Oct 2002 15:35:33 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:46830 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S265169AbSJWTfd>; Wed, 23 Oct 2002 15:35:33 -0400
Message-Id: <5.1.0.14.2.20021023123707.09b5b168@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 23 Oct 2002 12:41:15 -0700
To: jamal <hadi@cyberus.ca>, David Woodhouse <dwmw2@infradead.org>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: rtnetlink interface state monitoring problems. 
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
In-Reply-To: <Pine.GSO.4.30.0210222055170.24323-100000@shell.cyberus.ca>
References: <24818.1035226670@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamal,

>> But Bluetooth devices are not network devices, it seems. There exists no
>> current mechanism for notifying anyone of state changes. Should we invent a
>> new method of notification using netlink, or should Bluetooth interfaces in
>> fact be normal network devices just like IrDA devices are?
>>
>
>I think the only time you should go netdev is when it makes sense to run IP. 
Totally agree.

>Is there IP over bluttooth? 
Yep. It's called BNEP (Bluetooth Network Encapsulation Protocol) which is bascially
an Ethernet emulation. That thing is the netdev of course.

>Then you could take advantage of all the nice features provided by netdevices (other 
>than being IP devices;->).
>If not, it probably time for someone to write a generic notification
>scheme via netlink.
Might be interesting.

Max

