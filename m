Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264480AbRFPDeb>; Fri, 15 Jun 2001 23:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264515AbRFPDeW>; Fri, 15 Jun 2001 23:34:22 -0400
Received: from calnet3-192.gtecablemodem.com ([207.175.226.192]:36861 "EHLO
	dave.xdr.com") by vger.kernel.org with ESMTP id <S264480AbRFPDeI>;
	Fri, 15 Jun 2001 23:34:08 -0400
Date: Fri, 15 Jun 2001 20:25:43 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200106160325.UAA00890@dave.xdr.com>
To: linux-kernel@vger.kernel.org
Subject: psaux mouse driver + inland pro optical 100 mouse
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under linux 2.4.1 if I move the mouse slow enough it doesn't register at all
in Xwindows. If I unplug the ps2 mouse and plug it back in, it works
perfectly, no matter how slowly I move it the movement is registered. It
is as if the linux kernel is imposing a threshold on the movement.

Under windows it works fine. The problem is in linux.

I've tried modifying pc_keyb.c code by sending an F6 byte to set defaults,
using the aux_write_ack function in open_aux(), but that doesn't have any
effect. Does anyone have a clue what the driver is doing to reduce the
quality of the mouse? I'm not sure it is limited to this particular mouse,
it is just the one I just bought at Fry's for $10.

I'm running an athlon 1 gig, /proc/version is
Linux version 2.4.1 (root@dave) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #17 Fri Jun 15 20:15:45 PDT 2001

Thanks!
-Dave
