Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRBTTvV>; Tue, 20 Feb 2001 14:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130206AbRBTTvL>; Tue, 20 Feb 2001 14:51:11 -0500
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:738 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S129842AbRBTTu6>; Tue, 20 Feb 2001 14:50:58 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B74779718809AB@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: linux-kernel@vger.kernel.org
Subject: can somebody explain barrier() macro ?
Date: Tue, 20 Feb 2001 12:50:54 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

barrier() is defined in kernel.h as follows :

#define barrier() __asm__ __volatile__("": : :"memory")


what does this mean ? is this like "nop" ?

TIA,
-hiren
