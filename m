Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288731AbSANJSk>; Mon, 14 Jan 2002 04:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288752AbSANJSa>; Mon, 14 Jan 2002 04:18:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3857 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288731AbSANJSQ>; Mon, 14 Jan 2002 04:18:16 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ISA hardware discovery -- the elegant solution
Date: 14 Jan 2002 01:17:57 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1u7o5$p11$1@cesium.transmeta.com>
In-Reply-To: <20020113205839.A4434@thyrsus.com> <m1k7ulpbf7.fsf@frodo.biederman.org> <20020114034831.A5780@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020114034831.A5780@thyrsus.com>
By author:    "Eric S. Raymond" <esr@thyrsus.com>
In newsgroup: linux.dev.kernel
> 
> But the kernel itself has to know how to probe and initialize these devices
> at boot time, correct?  That information is implicitly exported via
> /var/log/dmesg -- I'm simply suggesting that it be a little more explicit.
> 

dmesg is lossy.  Don't assume it is complete.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
