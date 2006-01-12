Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWALRXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWALRXD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWALRXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:23:03 -0500
Received: from webapps.arcom.com ([194.200.159.168]:780 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S932278AbWALRXA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:23:00 -0500
Message-ID: <43C69067.9040206@arcom.com>
Date: Thu, 12 Jan 2006 17:22:47 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, oliver@neukum.org
Subject: Re: [linux-usb-devel] Re: need for packed attribute
References: <200601121227.k0CCRCB8016162@alkaid.it.uu.se> <20060112134729.GB5700@flint.arm.linux.org.uk> <17350.33811.433595.750615@alkaid.it.uu.se> <20060112164621.GA9288@flint.arm.linux.org.uk>
In-Reply-To: <20060112164621.GA9288@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jan 2006 17:26:43.0093 (UTC) FILETIME=[5B03FC50:01C6179D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> BTW, it's worth noting that the new EABI stuff has it's own set of
> problems.  We have r0 to r6 to pass 32-bit or 64-bit arguments.
> With EABI, 64-bit arguments will be aligned to an _even_ numbered
> register.

Is there a reason for this alignment requirement?

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
