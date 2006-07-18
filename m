Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWGRKHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWGRKHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWGRKHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:07:40 -0400
Received: from [216.208.38.107] ([216.208.38.107]:38272 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S932159AbWGRKHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:07:39 -0400
Subject: Re: [RFC PATCH 13/33] Add a new head.S start-of-day file for
	booting on Xen.
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060718091951.689269000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091951.689269000@sous-sol.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 12:06:35 +0200
Message-Id: <1153217196.3038.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (i386-head.S)
> When running on Xen, the kernel is started with paging enabled.  Also
> don't check for cpu features which are present on all cpus supported
> by Xen.

Hi, 

I didn't see much of this last sentence in the actual patch, which is
good, because I just don't see any reason to do that at all; if they
features are there anyway, why not preserve their detection, it's not
hurting and it means you need to be less different "just because"...

Greetings,
    Arjan van de Ven

