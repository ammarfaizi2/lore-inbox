Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264879AbSIRBAD>; Tue, 17 Sep 2002 21:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSIRBAD>; Tue, 17 Sep 2002 21:00:03 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:35738 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S264879AbSIRBAD>;
	Tue, 17 Sep 2002 21:00:03 -0400
Date: Tue, 17 Sep 2002 20:57:58 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Andrew Morton <akpm@digeo.com>
cc: "David S. Miller" <davem@redhat.com>, <manfred@colorfullife.com>,
       <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Info: NAPI performance at "low" loads
In-Reply-To: <3D87A59C.410FFE3E@digeo.com>
Message-ID: <Pine.GSO.4.30.0209172053360.3686-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Manfred, could you please turn MMIO (you can select it
via kernel config) and see what the new difference looks like?

I am not so sure with that 6% difference there is no other bug lurking
there; 6% seems too large for an extra two PCI transactions per packet.
If someone could test a different NIC this would be great.
Actually what would be even better is to go something like 20kpps,
50kpps, 80 kpps, 100kpps and 140 kpps and see what we get.

cheers,
jamal

