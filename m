Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRDKFfv>; Wed, 11 Apr 2001 01:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRDKFfl>; Wed, 11 Apr 2001 01:35:41 -0400
Received: from calnet3-192.gtecablemodem.com ([207.175.226.192]:4349 "EHLO
	dave.xdr.com") by vger.kernel.org with ESMTP id <S131246AbRDKFf3>;
	Wed, 11 Apr 2001 01:35:29 -0400
Date: Tue, 10 Apr 2001 22:30:41 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200104110530.WAA00945@dave.xdr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4 kernel problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

XFree86 X window updates are slower on 2.4 than 2.2, by a significant amount.
I've observed this comparing 2.2.18 with 2.4.1 and one of the 2.4.pre kernels.
I've seen it with ATI Rage 128, Geforce 1 and GeForce 2 MX. I've seen it on
two different computers, both Athlon based. Just any rectangular copies to
an X window are slow on 2.4 and much faster under 2.2.18.

I'm using DRI and accelerated GLX servers so I get good 3d, but 2d is
suffering in a *big* way. Here are some frames/second for a simple program:


Using shared memory       Kernel       frames/second
     yes                   2.4              39
     no                    2.4              30
     yes                   2.2.18          245
     no                    2.2.18           88

I can't get any response from the XFree86 team. I know I'm not the only
one with this trouble, something has been broken in the 2.4.

Thanks--
Dave
dash@xdr.com
