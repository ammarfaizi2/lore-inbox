Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265056AbUD3UhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbUD3UhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbUD3UhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:37:20 -0400
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:23440 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S265056AbUD3UhP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:37:15 -0400
Message-ID: <4092B861.8060601@stesmi.com>
Date: Fri, 30 Apr 2004 22:34:41 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
In-Reply-To: <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> The purpose of the workaround is not to circumvent any protection, but 
> to fix a real usability issue for systems in the field, which, as an 
> expert you perhaps do not see, but users definitely massively felt and 
> complained about.

That's like saying that someone hates getting a speeding ticket from
those automatic cameras that are cropping up everywhere now.

He then promptly removes his license plate so he can't be tracked and
then he can continue to speed along.

Now - To the entity that is issuing tickets it appears that that
person is now a law abiding citizen and does not speed anymore when
in truth he removed the plate so it would appear that way.

The speeding ticket is printed message.

Yes, it might or should be changed to print it once or once
per $MODULE_VENDOR or license or whatever, but the issue remains.

It wasn't YOU that installed the speed camera nor set the speed
limits (ie created the tained flag and the code that prints a
message when such a module is inserted) but claiming that
"but it's only a workaround because I was getting so many tickets"
doesn't make it any better.

Yes, Linux is such an open system that a user can install a kernel
that doesn't print anything for tained kernels (remove speed cameras)
but that doesn't mean that YOU can do anything about it from the side
of the car (module).

Also note that neither the speed camera nor the kernel actually make
any limits on speeding (loading proprietary modules).

// Stefan
