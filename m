Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUG3U1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUG3U1j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267835AbUG3U1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:27:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58329 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267831AbUG3U1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:27:25 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 13:26:48 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
References: <1091207136.2762.181.camel@rohan.arnor.net> <20040730172433.2312.qmail@web14924.mail.yahoo.com> <20040730191448.GA2461@ucw.cz>
In-Reply-To: <20040730191448.GA2461@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301326.48094.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 12:14 pm, Vojtech Pavlik wrote:
> I'm starting to think that using emu86 always (independent on the
> architecture) would be best. It's not like the execution speed is the
> limit with video init, and it'll allow to find more bugs in emu86 when
> it's used on i386 as well. It'll be needed for x86-64 (AMD64 and intel
> EM64T) anyway.

Yeah, I was thinking the same thing, but emu86 needs some fixes to work on an 
x86 host apparently...

Jesse
