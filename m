Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966484AbWKNXjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966484AbWKNXjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966463AbWKNXjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:39:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19886 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S966484AbWKNXjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:39:51 -0500
Date: Wed, 15 Nov 2006 00:39:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061114233936.GA3394@elf.ucw.cz>
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <20061114163002.GB4445@ucw.cz> <20061114231742.GE7030@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114231742.GE7030@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Vivek has tested this patch for suspend to memory and it works fine.
> > 
> > Ok, so it was tested on one config. Given that the patch deals with
> > detecting CPU oddities... :-(
> 
> This code has been lying in RHEL kernels for close to 3 months now.
> Have not heard of suspend/resume complaints. So hoping it got
> tested on wide variety of hardware too apart from testing on my machine.

Well, unless you have some way to restore video in RHEL, I'd not
expect many users of suspend to RAM... On systems without extensive
whitelist, s2ram is fairly hard to test.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
