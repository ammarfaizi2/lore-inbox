Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSKVUcS>; Fri, 22 Nov 2002 15:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSKVUcS>; Fri, 22 Nov 2002 15:32:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262296AbSKVUcS>; Fri, 22 Nov 2002 15:32:18 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Beginnings of conpat 32 code cleanups
Date: 22 Nov 2002 12:38:55 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <arm4kv$bsl$1@cesium.transmeta.com>
References: <20021122162312.32ff4bd3.sfr@canb.auug.org.au> <Pine.LNX.4.44.0211221141070.1440-100000@penguin.transmeta.com> <20021122115454.A481@work.bitmover.com> <20021122131351.C30808@duath.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20021122131351.C30808@duath.fsmlabs.com>
By author:    Cort Dougan <cort@fsmlabs.com>
In newsgroup: linux.dev.kernel
> 
> Plan9 takes it a step further and tackles the char/8-byte issue.  A
> printable character is a 16-byte entity - a rune - while char is an 8-byte
> quantity.  Doing everything in UNICODE forced the issue, I think.
> 

... at which point it promptly fell apart as 16-bit Unicode was very
quickly found to be insufficient (not really surprising since the
16-bit decision was based on technical convenience rather than actual
requirements.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
