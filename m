Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbULAXF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbULAXF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbULAXF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:05:27 -0500
Received: from NS1.idleaire.net ([65.220.16.2]:27349 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S261479AbULAXFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:05:22 -0500
Subject: Re: keyboard timeout
From: Dave Dillow <dave@thedillows.org>
To: linux-os@analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412011721090.8835@chaos.analogic.com>
References: <Pine.LNX.4.61.0412011721090.8835@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1101942309.6166.16.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 01 Dec 2004 18:05:09 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Dec 2004 23:05:09.0990 (UTC) FILETIME=[34BE5060:01C4D7FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 17:29, linux-os wrote:
> If Linux 2.6.9 is booted on a 40 MHz `486 with the standard
> ISA clock of 14.3 MHz (yes that's the standard), the kernel
> will complain about a keyboard timeout for every key touched!

Umm, no.

The BCLK signal, which is the system bus clock, is 4.77, 8.0, or 8.33
MHz, depending on platform. There may be other non-standard frequencies
in use. Since everything is referenced to this signal, I'd call it the
ISA clock.

You may be thinking of the OSC signal, which is 14.33MHz, and was used
to generate the composite video signal on early CGA cards. It is not
synchronized to any other signal. It is (was) also often divided by 12
and fed to the 8254 PIT.

As for your keyboard problem, I dunno. I just wanted to play "The find
the subtle misconception in Dick's post" game.

My reference: "ISA & EISA Theory & Operation" by Edward Solari.
-- 
Dave Dillow <dave@thedillows.org>

