Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbWGBSrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWGBSrd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbWGBSrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:47:33 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:32170 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932691AbWGBSrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:47:32 -0400
Date: Sun, 2 Jul 2006 20:47:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, akpm@osdl.org, rjw@sisk.pl,
       davej@redhat.com, linux-kernel@vger.kernel.org, sekharan@us.ibm.com,
       rusty@rustcorp.com.au
Subject: Re: 2.6.17-mm2
Message-ID: <20060702184720.GB7987@mars.ravnborg.org>
References: <20060624061914.202fbfb5.akpm@osdl.org> <20060624172014.GB26273@redhat.com> <20060624143440.0931b4f1.akpm@osdl.org> <200606251051.55355.rjw@sisk.pl> <20060625032243.fcce9e2e.akpm@osdl.org> <20060625081610.9b0a775a.akpm@osdl.org> <20060630003813.e1003a93.rdunlap@xenotime.net> <20060702101146.GA26924@flint.arm.linux.org.uk> <20060702114233.7880cf12.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060702114233.7880cf12.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Only if we have a policy of not exporting __init or __initdata or
> __exit.  Are we there yet??

On the principle of minimum suprise we shall no allow exported symbols
to magically disappear. Only some architectures do get rid of .init and
therefore a module may work with architecture one, but not architecture
two which is very unpredictable.

It should be established as a rule better now than later that this is a
no-go.

	Sam
