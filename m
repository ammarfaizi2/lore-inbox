Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVBAFzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVBAFzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 00:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVBAFzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 00:55:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:1708 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261591AbVBAFzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 00:55:40 -0500
Subject: Re: [PATCH] ppc64: Implement a vDSO and use it for signal
	trampoline
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050201054149.GA8136@mars.ravnborg.org>
References: <1107151447.5712.81.camel@gaston>
	 <20050131192713.GA16268@mars.ravnborg.org>
	 <1107218282.5906.33.camel@gaston> <20050201054149.GA8136@mars.ravnborg.org>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 16:55:01 +1100
Message-Id: <1107237301.5963.67.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Right hand side is evaluated only when left hand side is used.
> Also very usefull. Example just mocked up:
> cmd_vdso32_cc = $(CC) -T $^ -o $@
> 
> Doing late evaluation will cause correct replacement of $^ and $@ when
> used. When cmd_vdso_32 is defined make does not know the desired values
> for $^ and $@ - this is only known when cmd_vdso_32 is actually used.
> 
> Hope this clarifies it.

Definitely, thanks.

Ben.


