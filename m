Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269832AbTGKKHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 06:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266639AbTGKKHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 06:07:18 -0400
Received: from ns.suse.de ([213.95.15.193]:63503 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269832AbTGKKHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 06:07:05 -0400
Date: Fri, 11 Jul 2003 12:21:46 +0200
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Deprecate sysctl(2), add sysctl_name
Message-ID: <20030711102146.GB11119@wotan.suse.de>
References: <20030711014154.GA15238@wotan.suse.de> <Pine.LNX.4.44.0307101932510.5551-100000@home.osdl.org> <20030711091630.GA2707@wotan.suse.de> <1057918176.5804.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057918176.5804.0.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> how about rate limiting this ?

Only on demand. The only reasonable way would be to limit it per process
(print it once) 
but before doing that I would like to see if that's even needed.

Also I doubt sysctls are that commonly called if they are even used.

-Andi
