Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264439AbRFIIo3>; Sat, 9 Jun 2001 04:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264443AbRFIIoU>; Sat, 9 Jun 2001 04:44:20 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:52744 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264439AbRFIIoN>; Sat, 9 Jun 2001 04:44:13 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: temperature standard - global config option?
Date: 9 Jun 2001 01:43:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9fsnju$nqp$1@cesium.transmeta.com>
In-Reply-To: <20010608191600.A12143@alcove.wittsend.com> <200106090800.f5980i101507@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200106090800.f5980i101507@saturn.cs.uml.edu>
By author:    "Albert D. Cahalan" <acahalan@cs.uml.edu>
In newsgroup: linux.dev.kernel
> 
> I hope you don't think people would assume that a "float" always
> has useful data in all 23 fraction bits. It is a similar case.
> 
> So here you go, a kernel-safe conversion from C to K. It works
> from 0 to 238 degrees C. Print as hex, so user code can toss it
> into a union or maybe abuse scanf. Adjust as needed for F to K
> or for hardware with greater resolution.
> 

I hope you're not seriously suggesting we're using floats for this...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
