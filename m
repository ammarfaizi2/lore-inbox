Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbSJQWF4>; Thu, 17 Oct 2002 18:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262211AbSJQWF4>; Thu, 17 Oct 2002 18:05:56 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64018
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262198AbSJQWFz>; Thu, 17 Oct 2002 18:05:55 -0400
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, george anzinger <george@mvista.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0210171453050.2499-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0210171453050.2499-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Oct 2002 18:11:49 -0400
Message-Id: <1034892710.718.599.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-17 at 17:54, Randy.Dunlap wrote:

> Carrier Grade Linux is not a distro, but we do integrate these
> patches into the CGL patches and will continue to use it.
> 
> Please consider adding it to 2.5.

Indeed.  Linus, please consider merging at least George's latest patch
set which provides just the new system calls to support POSIX clocks and
timers.  There is no dependence on the high-resolution bits, so at least
Linux can provide the missing POSIX.4 system calls.

George can then provide the high resolution code separately which can be
debated and optionally merged.

	Robert Love

