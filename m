Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292883AbSCOQnH>; Fri, 15 Mar 2002 11:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292890AbSCOQm6>; Fri, 15 Mar 2002 11:42:58 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25880 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292883AbSCOQmj>; Fri, 15 Mar 2002 11:42:39 -0500
Date: Fri, 15 Mar 2002 17:43:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020315174358.J10073@dualathlon.random>
In-Reply-To: <andrea@suse.de> <20020312152534.U25226@dualathlon.random> <200203151720.g2FHKTgg014925@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203151720.g2FHKTgg014925@pincoya.inf.utfsm.cl>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 01:20:29PM -0400, Horst von Brand wrote:
> Andrea Arcangeli <andrea@suse.de> said:
> 
> [...]
> 
> > AFIK my current hashfn is never been tested in precendence on this kind
> > of random input of the wait_table pages.
> 
> If the input is really random, anything will do. I.e., just chopping off a
> few not guaranteed-zero bits (probably better low-end) and using that would
> be enough.

indeed, that's basically what I'm doing there (plus a "+ >>" just to use
more of the random bits).

Andrea
