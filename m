Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWCPXzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWCPXzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWCPXzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:55:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2789 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964911AbWCPXzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:55:38 -0500
Date: Thu, 16 Mar 2006 15:55:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #5]
In-Reply-To: <20060316231723.GB1323@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0603161551000.3618@g5.osdl.org>
References: <16835.1141936162@warthog.cambridge.redhat.com>
 <18351.1142432599@warthog.cambridge.redhat.com> <20060316231723.GB1323@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Mar 2006, Paul E. McKenney wrote:
> 
> Also, I have some verbiage and diagrams of Alpha's operation at
> http://www.rdrop.com/users/paulmck/scalability/paper/ordering.2006.03.13a.pdf
> Feel free to take any that helps.  (Source for paper is Latex and xfig,
> for whatever that is worth.)

This paper too claims that x86-64 has somehow different memory ordering 
constraints than regular x86. Do you actually have a source for that 
statement, or is it just a continuation of what looks like confusion in 
the Linux x86-64 header files?

(Also, x86 doesn't have an incoherent instruction cache - some older x86 
cores have an incoherent instruction decode _buffer_, but that's a 
slightly different issue with basically no effect on any sane program).

			Linus
