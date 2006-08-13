Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWHMAAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWHMAAv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 20:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWHMAAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 20:00:51 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:50696 "EHLO
	asav05.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S932402AbWHMAAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 20:00:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAOcH3kSBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Re: input: evdev.c EVIOCGRAB semantics question
Date: Sat, 12 Aug 2006 20:00:47 -0400
User-Agent: KMail/1.9.3
Cc: Magnus =?utf-8?q?Vigerl=C3=B6f?= <wigge@bigfoot.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <200608121724.16119.wigge@bigfoot.com> <20060812165228.GA5255@aehallh.com>
In-Reply-To: <20060812165228.GA5255@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122000.47904.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 August 2006 12:52, Zephaniah E. Hull wrote:
> I can dust off the masking patch sometime here if Dmitry thinks that
> he'd be willing to see a second method for this in addition to grabbing,
> adding support to xf86-input-evdev would be trivial, and the same could
> probably be said for the wacom driver that does grabbing at the moment.
> 

I would not mind if we get it working right ;) Do we need to turn off
"undesirable" handlers or do we want to limit output to one particular
handler? I'd prefer the former, if possible. Do we keep a counter or
set of counters so several processes can mask output, etc. Can we keep
event delivery somewhat fast? 

-- 
Dmitry
