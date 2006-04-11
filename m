Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWDKQ3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWDKQ3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWDKQ3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:29:48 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:34443 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750856AbWDKQ3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:29:47 -0400
Message-ID: <443BD96E.5060405@stesmi.com>
Date: Tue, 11 Apr 2006 18:29:34 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Ramakanth Gunuganti <rgunugan@yahoo.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
References: <20060411154944.65714.qmail@web54308.mail.yahoo.com> <Pine.LNX.4.61.0604111153001.29696@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0604111153001.29696@chaos.analogic.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig7D281CF4DFCB090D4EBB0611"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7D281CF4DFCB090D4EBB0611
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

linux-os (Dick Johnson) wrote:
> On Tue, 11 Apr 2006, Ramakanth Gunuganti wrote:
> 
> 
>>Thanks for the replies, talking to a lawyer seems to
>>be too stringent a requirement to even evaluate Linux.
>>Who would be the ultimate authority to give definitive
>>answers to these questions?
>>
>>Since it's the Linux kernel that's under GPLv2, any
>>work done here should be released under GPLv2. That
>>part seems to be clear, however any product would
>>include other things that could be proprietary. If
>>Linux kernel is made part of this proprietary package,
>>how does the distribution work. Can we just claim that
>>part of the package is under GPL and only release the
>>source code for the kernel portions.
>>
> 
> [See bottom. Please do not top-post.]
> 
> 
>>-Ram
>>
>>--- Kyle Moffett <mrmacman_g4@mac.com> wrote:
>>
>>
>>>On Apr 11, 2006, at 02:31:27, Ramakanth Gunuganti
>>>wrote:
>>>
>>>>I am trying to understand the GPL boundaries for
>>>
>>>Linux, any
>>>
>>>>clarification provided on the following issues
>>>
>>>below would be great:
>>>
>>>>[...]
>>>>Anyone trying to build a new application to work
>>>
>>>on Linux must have
>>>
>>>>these issues clarified, if you can share your
>>>
>>>experiences that
>>>
>>>>would be great too.
>>>
>>>If you're planning to make money off of any code
>>>developed based in
>>>part off of the Linux Kernel, you should definitely
>>>contact a lawyer
>>>familiar with the linux kernel and ask them.  Any
>>>advice you get from
>>>this list should probably come prefixed with
>>>"IANAL", and as such
>>>isn't worth terribly much.
>>>
>>>Cheers,
>>>Kyle Moffett
>>>
>>>
>>
> 
> Nobody can produce a definitive answer because nobody knows
> what you are doing. You could be making a module that exposes
> the entire contents of the kernel to user-space, then writing
> user-space programs that manipulate the kernel. Such user-space
> programs are then <probably> derived works and would need a GPL
> License.
> 
> On the other hand, you could be making a Hexagrid-confuser(tm)
> that runs a Pyrosynchrogem(tm), both proprietary items your
> company manufactures for the Red Sox. You need to make a kernel
> driver to interface with it, plus a whole bunch of proprietary
> user-mode software to help the Red Sox win another world series.
> In this case, only the driver needs to be GPL as long as it
> doesn't extend or modify the established Unix/Linux API. BUT,
> you imply that you need to modify the kernel in addition to
> writing a driver. This means that you are extending the API,
> which just __might__ require that any code that interfaces
> with that extension be GPL as well. That's why you __need__
> a lawyer if you are going to change the kernel to run your code.
> 
> Easiest way out is to make a conventional driver to interface
> with your device. Then write proprietary code that interfaces
> with it. Do not make any kernel changes, and do publish your
> driver under a GPL license.

Might be worth mentioning that if you intend to write a driver
that interfaces with any kernel under any license (bar any
kernel that you write yourself), be it Windows, Linux, *BSD,
etc you SHOULD talk to a lawyer as every license has it's
quirks and gotchas.

This is NOT specific to the GPL or the Linux kernel.

// Stefan

--------------enig7D281CF4DFCB090D4EBB0611
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEO9lzBrn2kJu9P78RA94rAJ99T/o+elnDkZcUOdDOFUaAcCLV4ACeP8kV
p3WnZTR5pn0IOlNStDP1nKY=
=u2Dx
-----END PGP SIGNATURE-----

--------------enig7D281CF4DFCB090D4EBB0611--
