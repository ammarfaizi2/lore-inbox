Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281464AbRKPSCg>; Fri, 16 Nov 2001 13:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281471AbRKPSC0>; Fri, 16 Nov 2001 13:02:26 -0500
Received: from ns.suse.de ([213.95.15.193]:13840 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281464AbRKPSCV>;
	Fri, 16 Nov 2001 13:02:21 -0500
Date: Fri, 16 Nov 2001 19:02:21 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New Power Managment code
In-Reply-To: <Pine.LNX.4.33.0111160952090.21985-100000@segfault.osdlab.org>
Message-ID: <Pine.LNX.4.30.0111161858520.22532-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Patrick Mochel wrote:

> > There were some bits at ftp://ftp.kernel.org/pub/people/mochel last time
> > I looked.
> That's where it is. The most recent drop is the -1115 patches.

I meant /pub/linux/kernel/people/ of course, but I'm sure James was
smart enough to figure that out 8)

> The power management transitions live in the most recent ACPI code, which
> you can get from Intel:

Something I'm curious on wrt to this new work. Would it make sense for
these callbacks to get called before/after APM suspend as well as ACPI ?
(I'm thinking of older pre-ACPI compliant boxes).

Saving state of devices etc seems a logical thing to do.

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

