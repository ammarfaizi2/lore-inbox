Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTDDFMd (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 00:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTDDFLI (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 00:11:08 -0500
Received: from are.twiddle.net ([64.81.246.98]:33224 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S263423AbTDDFFw (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 00:05:52 -0500
Date: Thu, 3 Apr 2003 21:17:18 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       grundler@parisc-linux.org, matthew@wil.cx, prumpf@tux.org
Subject: Re: [PATCH] HPUX/OSF4 personality issues in 2.5.
Message-ID: <20030403211718.A7962@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	grundler@parisc-linux.org, matthew@wil.cx, prumpf@tux.org
References: <20030404024540.4F6F62C15F@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030404024540.4F6F62C15F@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Apr 04, 2003 at 12:22:47PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 12:22:47PM +1000, Rusty Russell wrote:
> 2.4.20's personality.h:
> 	PER_OSF4 =		0x0010,			 /* OSF/1 v4 */
> 2.5.66's personality.h:
> 	PER_OSF4 =		0x000f,			 /* OSF/1 v4 */
> 
> So I assume 2.5 should be changed to match 2.4?

Presumably.  No one in userland actually uses PER_OSF4 though.
It's set by the kernel itself when it detects an osf executable.


r~
