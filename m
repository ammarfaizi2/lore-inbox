Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbSKUNCN>; Thu, 21 Nov 2002 08:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbSKUNCN>; Thu, 21 Nov 2002 08:02:13 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57094
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266638AbSKUNCM>; Thu, 21 Nov 2002 08:02:12 -0500
Date: Thu, 21 Nov 2002 05:08:45 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: David McIlwraith <quack@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: spinlocks, the GPL, and binary-only modules
In-Reply-To: <1037875005.1863.0.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10211210503090.3892-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 2002, Arjan van de Ven wrote:

> On Wed, 2002-11-20 at 03:49, David McIlwraith wrote:
> > How should it? The compiler (specifically, the C preprocessor) includes the
> > code, thus it is not the AUTHOR violating the GPL.
> 
> It is if the AUTHOR then decides to distribute the resulting binary
> which would contain a mix of GPL and non GPL work..

The mix is a direct result of developers knowingly inlining critical C
code into the headers.  If this code was placed in proper .c files and not
set in a .h then the potential for accidental mixing is removed.

This would limit and restrict the headers to being structs and extern
functions to call.

This would be the first step to narrow the grey and broaden the black and
white.

I expect to be showered with boos and go away stupid, followed by "We are
not here to make it easy for binary modules!  Go use BSD you moron!!!".

Cheers,

Andre Hedrick
LAD Storage Consulting Group

