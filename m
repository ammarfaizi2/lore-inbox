Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWGRKCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWGRKCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWGRKCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:02:15 -0400
Received: from [216.208.38.107] ([216.208.38.107]:30592 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S932151AbWGRKCO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:02:14 -0400
Subject: Re: [RFC PATCH 05/33] Makefile support to build Xen subarch
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060718091949.842251000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091949.842251000@sous-sol.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 12:00:13 +0200
Message-Id: <1153216813.3038.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (i386-mach-xen)
> Use arch/i386/mach-xen when building Xen subarch. The separate
> subarchitecture allows us to hide details of interfacing with the
> hypervisor from i386 common code.


Hi,

please change the order of your patches next time, by sending the
makefile and config options first you'll break git bisect...

Greetings,
    Arjan van de Ven

