Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbUKDTh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbUKDTh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUKDTYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:24:22 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:13660 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262376AbUKDTWG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:22:06 -0500
Subject: Re: belkin usb serial converter (mct_u232), break not working
From: Paul Fulghum <paulkf@microgate.com>
To: Thomas Stewart <thomas@stewarts.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200411041820.21847.thomas@stewarts.org.uk>
References: <200410201946.35514.thomas@stewarts.org.uk>
	 <1098362487.2815.9.camel@deimos.microgate.com>
	 <1098387861.3288.51.camel@deimos.microgate.com>
	 <200411041820.21847.thomas@stewarts.org.uk>
Content-Type: text/plain
Message-Id: <1099596101.2834.33.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 04 Nov 2004 13:21:41 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 12:20, Thomas Stewart wrote:
> I tried the converter on a XP machine and unfortunately while using the 
> manufacturer provided drivers I was unable to produce a break :-(

That seems consistent with the code, comments,
and observed behavior.

I doubt this device can generate a break.

> was told the product (F5U109ea) was designed for PDA use only and it would 
> generate breaks fine if connected to them.

Sounds like garbage (industry standard for phone support) to me.

I can't see how the bit pattern generated on TxD is dependent
on the attached device. The support person probably
has no idea what a break pattern is.

> Interestingly I got my hands on a F5U103 and it works fine (uses another chip 
> and consequently module).

This all looks like a missing/non-functioning feature
for the F5U109.

-- 
Paul Fulghum
paulkf@microgate.com

