Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbUAFBUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266059AbUAFBUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:20:41 -0500
Received: from us01smtp2.synopsys.com ([198.182.44.80]:9097 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S266058AbUAFBUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:20:39 -0500
Reply-To: <Paul.Zimmerman@synopsys.com>
From: "Paul Zimmerman" <Paul.Zimmerman@synopsys.com>
To: "Rob Landley" <rob@landley.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: udev and devfs - The final word
Date: Mon, 5 Jan 2004 17:20:37 -0800
Message-ID: <LNBBKKJNHNDCOAMAOENDAEAODGAA.paulz@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 January 2004 00:31 Rob Landley wrote:
> What about kernel upgrades?  Future backwards compatability when
developers
> change the device enumeration methods?  (The sata driver got completely
> rewritten from scratch, and now it detects devices in a wildly different
> order, but we need this shim layer for backwards compatability with a
> guarantee we never should have made because we encouraged old scripts to
> remain broken.)  This plants hidden land mines restricting future
> development.  You're basically proposing a whole "device number
stabilization
> infrastructure" for future kernels if it's to have ANY meaning at all...

Did people really write scripts that used major:minor numbers to refer to
devices? I would have thought they would use the /dev/xxx name, and those
will
not change when "random" device numbers are implemented, will they?

- Paul

