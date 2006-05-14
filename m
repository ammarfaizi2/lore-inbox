Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWENH5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWENH5A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 03:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWENH5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 03:57:00 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:43395 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751371AbWENH47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 03:56:59 -0400
In-Reply-To: <200605131346_MC3-1-BFAF-FA0A@compuserve.com>
References: <200605131346_MC3-1-BFAF-FA0A@compuserve.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <96b6a9b036fc030017549f3446a13aab@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Ian Pratt <Ian.Pratt@xensource.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       virtualization <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 23/35] Increase x86 interrupt vector range
Date: Sun, 14 May 2006 08:52:24 +0100
To: Chuck Ebbert <76306.1226@compuserve.com>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 May 2006, at 18:44, Chuck Ebbert wrote:

> AFAIC this could go in anytime.  It's simple, self-contained and makes
> sense even without Xen.
>
> One minor nit: the IRQ value isn't negated, it's complemented.  The
> comments need to be fixed.

If we really want it disambiguated then we should call it something 
like 'bitwise-negated' or 'ones-complemented'. 'Complemented' alone is 
worse than 'negated' imo, since negation is at least the usual name for 
the tilde operator in C while complementation is an ambiguous term 
unless you know the base/radix.

  -- Keir

