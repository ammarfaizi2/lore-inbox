Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVATUDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVATUDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVATUBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:01:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40090 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261905AbVATT7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:59:14 -0500
Date: Wed, 19 Jan 2005 16:48:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: short read from /dev/urandom
Message-ID: <20050119154854.GD476@openzaurus.ucw.cz>
References: <41E7509E.4030802@redhat.com> <20050114191056.GB17481@thunk.org> <41E833F4.8090800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E833F4.8090800@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> >What do you think?  Does gcc -pg calls sigaction with SA_RESTART, to
> >avoid changing the behaviour of the programs that it is profiling?
> 
> Profiling certainly uses SA_RESTART.  But this was just one possible 
> problem case.
> 
> I'm concerned that there is isgnificant code out there relying on the 
> no-short-read promise.  And perhaps more importantly, other 
> implementations promise the same.

Well, but such code will need to be fixed, anyway; pre-2.6.10 kernels
will stay here for quite a long time.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

