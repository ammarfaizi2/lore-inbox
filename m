Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315964AbSEGUUi>; Tue, 7 May 2002 16:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315965AbSEGUUh>; Tue, 7 May 2002 16:20:37 -0400
Received: from florence.ie.alphyra.com ([193.120.224.170]:56988 "EHLO
	florence.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S315964AbSEGUUg>; Tue, 7 May 2002 16:20:36 -0400
Date: Tue, 7 May 2002 21:20:12 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Samuel Maftoul <maftoul@esrf.fr>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: eepro100: wait_for_cmd_done timeout (2.4.19-pre2/8)
In-Reply-To: <Pine.LNX.3.95.1020507111647.7166A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0205072058590.16371-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Richard B. Johnson wrote:

> No. I told someone to comment out a call to wait_for_cmd_timeout() in
> a procedure where this generates spurious (incorrect) warning messages.

ah.. not spurious.

> You are probably getting real errors (the chip stops) when its interrupts
> can't be handled quickly enough.

the server i have has no network connectivity via that interface while 
this is going on.

anyway... i rebooted the machine and (so far, touch wood, fingers 
crossed) it hasnt shown the problem so far. (odd cause i rebooted the 
thing several times last friday and it didnt clear the problem).

/before/ the reboot i set multicast_filter_limit=1, downed the 
interface, removed the module and upped it again (after waiting) but 
this made no difference. however, the reboot (with this parameter set) 
made a difference where before reboots made no difference.

anyway, Richard, have you spoken to andrey (saw@saw.sw.com.sg -
current maintainer) about your fix and whether it is proper or not?

regards,

--paulj

