Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130889AbQLHBrZ>; Thu, 7 Dec 2000 20:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130324AbQLHBrP>; Thu, 7 Dec 2000 20:47:15 -0500
Received: from mx7.sac.fedex.com ([199.81.194.38]:35333 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S130889AbQLHBrG>; Thu, 7 Dec 2000 20:47:06 -0500
Date: Fri, 8 Dec 2000 09:12:48 +0800
From: Jeff Chua <jchua@fedex.com>
Message-Id: <200012080112.eB81Cmu23816@silk.corp.fedex.com>
To: linux-kernel@vger.kernel.org, vivek_dasgupta@email.com
Subject: RE: Ramdisk root filesystem strangeness
Cc: carlson@sibyte.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Is there support for using RAMDISK as the final root file system
>in 2.2.x versions, or is it there in the 2.4.x versions.

Works with 2.2x and up to 2.4.0 test12-pre3.bz2

Make sure you specify the following if you're using loadlin

	root=/dev/ram

With anything above test12-pre3.bz2, you'll ran into the following problem

kernel BUG at buffer.c:827!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0135e13>]
EFLAGS: 00010286


Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
