Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281496AbRKPTSB>; Fri, 16 Nov 2001 14:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281497AbRKPTRv>; Fri, 16 Nov 2001 14:17:51 -0500
Received: from air-1.osdl.org ([65.201.151.5]:33436 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S281496AbRKPTRm>;
	Fri, 16 Nov 2001 14:17:42 -0500
Date: Fri, 16 Nov 2001 11:20:21 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Dave Jones <davej@suse.de>
cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New Power Managment code
In-Reply-To: <Pine.LNX.4.30.0111161858520.22532-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0111161117520.21985-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Something I'm curious on wrt to this new work. Would it make sense for
> these callbacks to get called before/after APM suspend as well as ACPI ?
> (I'm thinking of older pre-ACPI compliant boxes).
>
> Saving state of devices etc seems a logical thing to do.

Yes, it's entirely possible, and seems like a good thing to do.

The original motivation behind it was to replace struct pm_dev and the
callbacks for it. I haven't looked it into replacing them in the APM code
or the power management code for other architectures, but it shouldn't be
that painful. Hopefully.

	-pat

