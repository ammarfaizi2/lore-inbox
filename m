Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbTBFGxZ>; Thu, 6 Feb 2003 01:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbTBFGxZ>; Thu, 6 Feb 2003 01:53:25 -0500
Received: from 213-152-55-49.dsl.eclipse.net.uk ([213.152.55.49]:15768 "EHLO
	monkey.daikokuya.co.uk") by vger.kernel.org with ESMTP
	id <S265578AbTBFGxY>; Thu, 6 Feb 2003 01:53:24 -0500
Date: Thu, 6 Feb 2003 07:02:56 +0000
From: Neil Booth <neil@daikokuya.co.uk>
To: Jeff Muizelaar <muizelaar@rogers.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030206070256.GB30345@daikokuya.co.uk>
References: <1044385759.1861.46.camel@localhost.localdomain.suse.lists.linux.kernel> <200302041935.h14JZ69G002675@darkstar.example.net.suse.lists.linux.kernel> <b1pbt8$2ll$1@penguin.transmeta.com.suse.lists.linux.kernel> <p73znpbpuq3.fsf@oldwotan.suse.de> <3E4045D1.4010704@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4045D1.4010704@rogers.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Muizelaar wrote:-

> There is also tcc (http://fabrice.bellard.free.fr/tcc/)
> It claims to support gcc-like inline assembler, appears to be much 
> smaller and faster than gcc. Plus it is GPL so the liscense isn't a 
> problem either.

It doesn't expand macros correctly, however, and accepts an enormous
range of invalid code without a single diagnostic.  I'm pretty sure
it's arithmetic rules are incorrect, too.  It's certainly nowhere
near C89 compliance.

Neil.
