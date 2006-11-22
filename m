Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756014AbWKVXFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbWKVXFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757130AbWKVXFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:05:18 -0500
Received: from rtr.ca ([64.26.128.89]:45327 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1756014AbWKVXFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:05:17 -0500
Message-ID: <4564D7AB.3000601@rtr.ca>
Date: Wed, 22 Nov 2006 18:05:15 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] PM: suspend/resume debugging should depend on  SOFTWARE_SUSPEND
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>
> Sane people use suspend-to-ram, and that's when you need the suspend and 
> resume debugging.
> 
> Software-suspend is silly. I want my machine back in three seconds, not 
> waiting for minutes..

ALL of my notebooks here have always been capable of Suspend-to-RAM with Linux,
and that's how I like it.  We've had six different models (IBM, Dell, Toshiba),
and they have all worked fine with S2R.

The older APM ones had zero issues, and just always worked.

The newer ACPI ones have required some tweaking to the sleep/wakeup scripts,
but now work perfectly with suspend-to-ram.

Suspend-to-disk (and resume from disk) are way too slow for regular use,
except of course for the swsusp2 version, which is nearly as quick as S2R is.

I do use S2D when travelling, as it's much easier on the batteries while
the notebook is packed away on the red-eye flights.

Cheers
