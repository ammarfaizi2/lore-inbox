Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWGRWzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWGRWzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWGRWzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:55:37 -0400
Received: from gw.goop.org ([64.81.55.164]:46775 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932356AbWGRWzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:55:36 -0400
Message-ID: <44BD40F4.2060307@goop.org>
Date: Tue, 18 Jul 2006 13:13:40 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 13/33] Add a new head.S start-of-day file for	booting
 on Xen.
References: <20060718091807.467468000@sous-sol.org>	 <20060718091951.689269000@sous-sol.org> <1153217196.3038.28.camel@laptopd505.fenrus.org>
In-Reply-To: <1153217196.3038.28.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> I didn't see much of this last sentence in the actual patch, which is
> good, because I just don't see any reason to do that at all; if they
> features are there anyway, why not preserve their detection, it's not
> hurting and it means you need to be less different "just because"...
>   
mach-xen/head.S is simpler than kernel/head.S, partly because it doesn't 
contain the CPU identification and feature tests (cpuid is assumed, 
though ironically, we don't actually use it).

    J

