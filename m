Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbWFVCxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbWFVCxa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 22:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbWFVCxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 22:53:30 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:25218
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1030541AbWFVCx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 22:53:29 -0400
Message-ID: <449A0623.8050601@microgate.com>
Date: Wed, 21 Jun 2006 21:53:23 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add synclink_gt custom hdlc idle
References: <1150900076.3708.2.camel@amdx2.microgate.com> <20060621192017.4ca27f33.akpm@osdl.org>
In-Reply-To: <20060621192017.4ca27f33.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> What's a custom HDLC idle pattern feature?

It allows the user to specify an arbitrary 8 or
16 bit repeating pattern on the transmit data pin between
HDLC frames.

In most cases the idle pattern is continuous
ones or flags as supported by off the shelf
synchronous controllers and defined in the ISO3309 standard.
Some applications (radio/satellite modems, connections to
legacy military hardware) require non-standard patterns.

--
Paul
