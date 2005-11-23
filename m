Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbVKWW6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbVKWW6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbVKWW6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:58:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38578 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030471AbVKWW63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:58:29 -0500
Date: Wed, 23 Nov 2005 23:58:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
       linux-pm@lists.osdl.org, akpm@osdl.org
Subject: Re: [Patch 0/6] Remove Deprecated PM Interface from Obsolete Sound Drivers
Message-ID: <20051123225814.GF24220@elf.ucw.cz>
References: <Pine.LNX.4.50.0511231114340.14446-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0511231114340.14446-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is a series of 6 patches that remove the old, deprecated power
> management interface from a variety of old OSS drivers, most of them
> marked OBSOLETE and scheduled for removal in January 2006.

It may be nice to develop some macros/tricks to convert those into
platform devices quickly. This would actually have chance of not
breaking suspend/resume on affected drivers. (Not that it matters for
these).

								Pavel
-- 
Thanks, Sharp!
