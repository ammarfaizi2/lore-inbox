Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbSLTAUW>; Thu, 19 Dec 2002 19:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbSLTAUW>; Thu, 19 Dec 2002 19:20:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:1664 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267374AbSLTAUW>;
	Thu, 19 Dec 2002 19:20:22 -0500
Message-ID: <3E0263EA.2BB9C89@digeo.com>
Date: Thu, 19 Dec 2002 16:27:22 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
References: <200212200850.32886.conman@kolivas.net>
		 <1040337982.2519.45.camel@phantasy>  <3E0253D9.94961FB@digeo.com> <1040341293.2521.71.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Dec 2002 00:28:18.0473 (UTC) FILETIME=[B194A990:01C2A7BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> I actually have a 2.5.52 patch out which
> is a bit cleaner - it removes the defines completely and uses the new
> variables.

I actually don't mind the

#define TUNABLE (tunable)

thing, because when you look at the code, it tells you that
TUNABLE is "special".  Not a local variable, not a formal arg,
not (really) a global variable.  It aids comprehension.

Prefixing all the names with "tune_" would suit, too.
