Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbTBYHsS>; Tue, 25 Feb 2003 02:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267813AbTBYHsS>; Tue, 25 Feb 2003 02:48:18 -0500
Received: from are.twiddle.net ([64.81.246.98]:27040 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267812AbTBYHsR>;
	Tue, 25 Feb 2003 02:48:17 -0500
Date: Mon, 24 Feb 2003 23:58:29 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] eliminate warnings in generated module files
Message-ID: <20030224235829.A12782@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030218184317.A20436@twiddle.net> <20030225050306.F0BF82C19D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030225050306.F0BF82C19D@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Feb 25, 2003 at 03:32:21PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 03:32:21PM +1100, Rusty Russell wrote:
> In message <20030218184317.A20436@twiddle.net> you write:
> > +#if __GNUC__ == 3 && __GNUC_MINOR__ >= 3 || __GNUC__ > 3
> > +#define __attribute_used__	__attribute__((__used__))
> > +#else
> > +#define __attribute_used__	__attribute__((__unused__))
> > +#endif
> > +
> 
> After some thought, I prefer __optional.

Um, "optional" does not in any way accurately describe attribute used.
In fact, it means almost exactly the opposite.


r~
