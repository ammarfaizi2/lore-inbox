Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281241AbRKHBoG>; Wed, 7 Nov 2001 20:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281249AbRKHBn4>; Wed, 7 Nov 2001 20:43:56 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:26118 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S281241AbRKHBno>; Wed, 7 Nov 2001 20:43:44 -0500
Date: Thu, 8 Nov 2001 10:44:25 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: erik@hensema.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Yet another design for /proc. Or actually /kernel.
Message-Id: <20011108104425.496f717d.rusty@rustcorp.com.au>
In-Reply-To: <slrn9uj1nf.5lj.spamtrap@dexter.hensema.xs4all.nl>
In-Reply-To: <slrn9uj1nf.5lj.spamtrap@dexter.hensema.xs4all.nl>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Nov 2001 19:09:35 GMT
spamtrap@use.reply-to (Erik Hensema) wrote:

> 
> Here's my go at a new design for /proc. I designed it from a userland
> point of view and tried not to drown myself into details.

> - Multiple values per file when needed
> 	A file is a two dimensional array: it has lines and every line
> 	can consist of multiple fields.
> 	A good example of this is the current /proc/mounts.
> 	This can be parsed very easily in all languages.
> 	No need for single-value files, that's oversimplification.

No, it deals nicely with any possible values in the file.  And without headers,
how do I know what's what?  And how do I update one value.

Meanwhile, there's far too much talk, far too little code.  Will post new patch
next week.

Rusty.
