Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWHZMQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWHZMQy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 08:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWHZMQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 08:16:54 -0400
Received: from khc.piap.pl ([195.187.100.11]:53923 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964941AbWHZMQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 08:16:53 -0400
To: Theodore Tso <tytso@mit.edu>
Cc: Stuart MacDonald <stuartm@connecttech.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org,
       "'LKML'" <linux-kernel@vger.kernel.org>, libc-alpha@sources.redhat.com
Subject: Re: Serial custom speed deprecated?
References: <1156459387.3007.218.camel@localhost.localdomain>
	<043501c6c85a$1eb09a60$294b82ce@stuartm>
	<20060825193203.GB725@flint.arm.linux.org.uk>
	<20060825203929.GB25595@thunk.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 26 Aug 2006 14:16:50 +0200
In-Reply-To: <20060825203929.GB25595@thunk.org> (Theodore Tso's message of "Fri, 25 Aug 2006 16:39:29 -0400")
Message-ID: <m3irkf66a5.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso <tytso@mit.edu> writes:

> What would scare me though about doing something like would be
> potential for the ABI changes.  Not only do you have to worry about a
> consistent set of ioctl's, structure definitions, and B* defines, but
> you also have to worry about userspace libraries that use B* as part
> of their interface, and expect user programs to pass B* constants to
> the userspace library.  (Say, some kind of conveience dialout library,
> for example.)

Right, there is a potential problem here. I don't know | think
if anything like that exists, though. If there is no such software
the issue can be ignored, and if something turns out then it just
have to be compiled with the same glibc headers (both parts).
That probably means even for binary software it's a non-issue.
-- 
Krzysztof Halasa
