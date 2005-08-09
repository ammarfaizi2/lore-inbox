Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVHISND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVHISND (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 14:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVHISNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 14:13:01 -0400
Received: from digitalimplant.org ([64.62.235.95]:40838 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S964907AbVHISNA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 14:13:00 -0400
Date: Tue, 9 Aug 2005 11:12:45 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Todd Poynor <tpoynor@mvista.com>
cc: linux-kernel@vger.kernel.org, "" <linux-pm@lists.osdl.org>,
       "" <cpufreq@www.linux.org.uk>
Subject: Re: [linux-pm] PowerOP 0/3: System power operating point management
 API
In-Reply-To: <20050809024907.GA25064@slurryseal.ddns.mvista.com>
Message-ID: <Pine.LNX.4.50.0508091110430.19925-100000@monsoon.he.net>
References: <20050809024907.GA25064@slurryseal.ddns.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Aug 2005, Todd Poynor wrote:

> PowerOP is a system power parameter management API submitted for
> discussion.  PowerOP writes and reads power "operating points",
> comprised of arbitrary integer-valued values, called power parameters,
> that correspond to registers, clocks, dividers, voltage regulators,
> etc. that may be modified to set a basic power/performance point for the
> system.  The core basically passes an array of integer-valued power
> parameters (with very little additional structure imposed by the core)
> to a platform-specific backend that interprets those values and makes
> the requested adjustments.  PowerOP is intended to leave all power
> policy decisions to higher layers.  An optional sysfs representation of
> power parameters is also available, primarily for diagnostic use.

What do those higher layers look like? Do you have a userspace component
that uses this interface?

Who is using this code? Are there vendors that are already shipping
systems with this enabled?

Is this part of the DPM project? If so, what other components are left in
DPM?

What are your plans to integrate this more with the cpufreq code?

Thanks,


	Pat

