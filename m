Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWCHXfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWCHXfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWCHXfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:35:52 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:33493 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751505AbWCHXfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:35:50 -0500
Date: Wed, 08 Mar 2006 17:34:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: de2104x: interrupts before interrupt handler is registered
In-reply-to: <Pine.LNX.4.61.0603080658580.12681@chaos.analogic.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <440F6A0D.3040704@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5N5Ql-30C-11@gated-at.bofh.it> <5NnDE-44v-11@gated-at.bofh.it>
 <440CCD9A.3070907@shaw.ca>
 <Pine.LNX.4.61.0603070705490.8536@chaos.analogic.com>
 <440D918D.2000502@shaw.ca>
 <Pine.LNX.4.61.0603070908460.9133@chaos.analogic.com>
 <440E1E9F.3020208@shaw.ca>
 <Pine.LNX.4.61.0603080658580.12681@chaos.analogic.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> You don't bother to read. The reported interrupt is WRONG, INVALID,
> INCORRECT, BROKEN, until __after__ the device is enabled. That means
> that one CANNOT put an interrupt handler in place before the
> device is enabled.

And my point is, even if you COULD put an interrupt handler into place 
before enabling the device, if the device can be in an unstable state 
such that the interrupt can't be acknowledged reliably, how can you 
handle it without causing an interrupt storm?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca


