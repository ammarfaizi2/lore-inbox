Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbULUX0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbULUX0D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbULUX0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:26:03 -0500
Received: from gprs214-215.eurotel.cz ([160.218.214.215]:11649 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261893AbULUXZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:25:58 -0500
Date: Wed, 22 Dec 2004 00:25:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, torvalds@osdl.org
Subject: Re: Cleanup PCI power states
Message-ID: <20041221232510.GB1218@elf.ucw.cz>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113631.GB1027@elf.ucw.cz> <20041217220208.GA22752@kroah.com> <20041217235051.GC29084@elf.ucw.cz> <20041221200333.GA9577@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221200333.GA9577@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This should reduce number of warnings in pci.c. It will still warn on
> > comparison (because we are using __bitwise, but in fact we want
> > something like "this is unique but arithmetic is still ok"), but that
> > probably needs to be fixed in sparse.
> > 
> > Also killed "function does not return anything" warning.
> > 
> > Please apply,
> 
> What kernel tree is this against?  I get rejects in the second hunk.

Strange, it applied okay here over latest -bk. What tree should I
generate it against?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
