Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbUJ1GnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbUJ1GnX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbUJ1GnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:43:19 -0400
Received: from colino.net ([213.41.131.56]:58621 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262811AbUJ1Ghk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:37:40 -0400
Date: Thu, 28 Oct 2004 08:37:16 +0200
From: Colin Leroy <colin@colino.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: don't spit out too much errors with suspended
 devices
Message-ID: <20041028083716.5ab62064.colin@colino.net>
In-Reply-To: <200410271613.56201.david-b@pacbell.net>
References: <20041026172843.6ac07c1a.colin@colino.net>
	<200410260905.14869.david-b@pacbell.net>
	<20041027091925.56d31d91.colin@colino.net>
	<200410271613.56201.david-b@pacbell.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs132.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Oct 2004 at 16h10, David Brownell wrote:

Hi, 

> The "message.c" part is fine, but the usbfs/devio change
> only tests one of several paths for device access.  (My
> first whack at this only covered a different one!)  Can
> you verify this one instead?

I'll do; I'll get back to you next week probably, because
I'll be busy this week-end, and I'm avoiding 2.6.10-rc1 until
ppc fixes go in: Citing Benjamin Herrenschmidt:

> Well, I'd suggest not running that kernel until paul's signal fix gets
> in, there is a FP register corruption in there... There are other issues
> with 2.6.10 currently, so it's not really a good kernel to play with for
> now.

-- 
Colin
