Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319088AbSHSWrR>; Mon, 19 Aug 2002 18:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319089AbSHSWrR>; Mon, 19 Aug 2002 18:47:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28679 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319088AbSHSWrQ>; Mon, 19 Aug 2002 18:47:16 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: MAX_PID changes in 2.5.31
Date: 19 Aug 2002 15:51:00 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ajrsok$p0m$1@cesium.transmeta.com>
References: <200208192236.g7JMaxS28968@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.44.0208200040010.5356-100000@localhost.localdomain> <200208192242.g7JMgmD29241@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200208192242.g7JMgmD29241@vindaloo.ras.ucalgary.ca>
By author:    Richard Gooch <rgooch@ras.ucalgary.ca>
In newsgroup: linux.dev.kernel
> 
> Ah, OK. So if I leave /proc/sys/kernel/pid_max alone, nothing will
> break. Will the default ever change, or do you plan on leaving it as
> is?
> 

It probably should change at some point.  I would favour changing the
default to aggressive in 2.5, to smoke out bugs, and perhaps turn it
back to conservative in 2.6.  In 2.7, we probably should turn on
aggressive for good.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
