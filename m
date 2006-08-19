Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422709AbWHSBVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbWHSBVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 21:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWHSBVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 21:21:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55818 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161104AbWHSBVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 21:21:34 -0400
Date: Sat, 19 Aug 2006 03:21:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] paravirt.h
Message-ID: <20060819012133.GH7813@stusta.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <44DB7596.6010503@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44DB7596.6010503@goop.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 11:06:14AM -0700, Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> >+EXPORT_SYMBOL_GPL(paravirt_ops);
> >  
> This should probably be EXPORT_SYMBOL(), otherwise pretty much every 
> driver module will need to be GPL...

These are Linux specific operations.

Without an _GPL you are in the grey area where courts have to decide 
whether a module using this would be a derived work according to 
copyright law in $country_of_the_court and therefore has to be GPL.

With the _GPL, everything is clear without any lawyers involved.

>    J

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

