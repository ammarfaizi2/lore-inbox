Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135656AbRDXRoX>; Tue, 24 Apr 2001 13:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135647AbRDXRoO>; Tue, 24 Apr 2001 13:44:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60676 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S135595AbRDXRoC>;
	Tue, 24 Apr 2001 13:44:02 -0400
Date: Tue, 24 Apr 2001 18:43:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: imel96@trustix.co.id
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
Message-ID: <20010424184347.A3416@flint.arm.linux.org.uk>
In-Reply-To: <Pine.GSO.4.21.0104240752320.6992-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0104241917540.16169-100000@tessy.trustix.co.id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104241917540.16169-100000@tessy.trustix.co.id>; from imel96@trustix.co.id on Tue, Apr 24, 2001 at 07:44:17PM +0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 07:44:17PM +0700, imel96@trustix.co.id wrote:
> come on, it's hard for me as it's hard for you. not everybody
> expect a computer to be like people here thinks how a computer
> should be.

I'm sorry, you're looking at the problem the wrong way around.
Its not a kernel problem, but a user space problem.

> think about personal devices. something like the nokia communicator.
> a system security passwd is acceptable, but that's it. no those-
> device-user would like to know about user account, file ownership,
> etc. they just want to use it.

If you do everything as one user, then you are effectively in a
single-user mode.  Just make sure that the user owns all the files
that they might need.

Your change still doesn't get rid of the /bin/login program - you still
have to do that, so why not do it anyway?

Also, I know of no personal device that gives you access to system
software (which is effectively what giving a user 'root' access
gives you).  How many users do you know who can copy the firmware
in their phone or organiser?

> that also explain why win95 user doesn't want to use NT. not
> because they can't afford it (belive me, here NT costs only
> us$2), but additional headache isn't acceptable.

I'm sorry, that's a different problem, and _even_ Windows 95 and 98
has a "User Logon".  Only if you use the system in a single user mode
does it not have a logon.  You can do the same with Linux again
without making kernel modifications.

I'd like to point out that RedHat have thought about this, and they
have some of the infrastructure in there to automatically log you
on at boot time in (within X).

As I say, this is a user space issue, and distributions are addressing
it adequately.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

