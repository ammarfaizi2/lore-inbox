Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284472AbRL1VX5>; Fri, 28 Dec 2001 16:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284280AbRL1VXr>; Fri, 28 Dec 2001 16:23:47 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:18292 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S284506AbRL1VXl>; Fri, 28 Dec 2001 16:23:41 -0500
Posted-Date: Fri, 28 Dec 2001 21:23:33 GMT
Date: Fri, 28 Dec 2001 21:23:32 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
In-Reply-To: <20011228133459.Y12868@lynx.no>
Message-ID: <Pine.LNX.4.21.0112282121040.3044-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas.

>> Can I suggest an alternative: Retain the MAINTAINERS file as it
>> currently is, but add a PATCHES-TO file in each subdirectory that
>> states how to handle patches relating to that directory, and have
>> these files follow a strict format, possibly...
>> 
>> ===8<=== CUT ===>8===
>> 
>> HomeDir = linux/subsystem/
>> List = subsystem@server.site
>> Maintainer = Guess Who <uessWho@hear.thou.me>
>> Watch * = Interested <interested@private.site>
>> Watch PATCHES-TO = John Doa <administrator@linux.org>
>> 
>> ===8<=== CUT ===>8===
>> 	WATCH filespec = name <email-address>
>> 
>> 		Specifies that the email address specified is also
>> 		interested in patches relating to the specified
>> 		files, and should be CC'd patches relating to just
>> 		the files specified. Files of interest are selected
>> 		using ls style wildcards. Can be repeated as often
>> 		as required for either the same or different files.
>> 		The filespec can not contain / characters, and only
>> 		matches files in the current directory.

> I'd rather just skip the WATCH part entirely (or limit it to people
> already in the MAINTAINERS list).

That's a policy decision for the maintainers to make.

> If someone is interested in part of the code, they can subscribe to
> the mailing list.

What if there isn't a mailing list for that part of the code and they
can't handle the volume on L-K ???

> Also, if the PATCHES-TO file already lives in a particular
> subdirectory, I don't see the benefit of HomeDir, except to
> increase the maintenance work.

Basically, it confirms that you're looking at the right PATCHES-TO file.

Best wishes from Riley.

