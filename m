Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269796AbRHYRJV>; Sat, 25 Aug 2001 13:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269804AbRHYRJM>; Sat, 25 Aug 2001 13:09:12 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:28173 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269796AbRHYRIz>;
	Sat, 25 Aug 2001 13:08:55 -0400
Message-Id: <200108240031.EAA00336@mops.inr.ac.ru>
Subject: Re: hardware checksumming
To: cwidmer@iiic.ethz.ch
Date: Fri, 24 Aug 2001 04:31:51 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200108231458.f7NEwqk24604@mail.swissonline.ch> from "Christian Widmer" at Aug 23, 1 07:15:02 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> but receiving is difficult 

Hmm... on receiving it is enough trivial and we do this.


> something else: you need quite a lot of ram on the NIC to buffer fragments.

A lot? Even ne2000 had 16K of memory, which is enough to do this. 
It is the first.

Card need not hold fragments, it may send fragments in backward order.
It is the second.

Well, and the last but not the least: acenic has exactly this amount
of memory: "lots" :-) It is the third. :-)


> do you know any NIC that is capable of chaining?

acenic. We do not use this, though this is also not difficult.

Alexey
