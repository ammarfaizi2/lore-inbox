Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbSLIUNV>; Mon, 9 Dec 2002 15:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266157AbSLIUNV>; Mon, 9 Dec 2002 15:13:21 -0500
Received: from smtp10.wxs.nl ([195.121.6.35]:41434 "EHLO smtp10.wxs.nl")
	by vger.kernel.org with ESMTP id <S266135AbSLIUNU>;
	Mon, 9 Dec 2002 15:13:20 -0500
Date: Mon, 09 Dec 2002 21:21:52 +0100
From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: Re: 486 laptop apm problems
To: linux-kernel@vger.kernel.org
Message-id: <1039465312.13684.39.camel@localhost>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.0
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Triebel wrote:
> apm: BIOS version 0.1 Flags 0x03 (Driver version 1.16)
> [...]
> how should I use such an old apm bios?

At least one other old Compaq laptop reports APM BIOS
version 0.1 when it is actually 1.0.  The apm driver
works around this by interpreting a 0.1 BIOS as 1.0.

> apm: an event queue overflowed

This suggests that your BIOS is generating events
faster than they can be read, which is troubling.

> why does apmd frequently crash?

Does apmd generate any messages when it crashes?

-- 
Thomas Hood <jdthood@yahoo.co.uk>

