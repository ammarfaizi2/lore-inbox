Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUE0TOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUE0TOm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbUE0TOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:14:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28114 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265053AbUE0TOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:14:41 -0400
Date: Mon, 24 May 2004 12:12:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
Message-ID: <20040524101219.GI5215@openzaurus.ucw.cz>
References: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com> <20040520234006.291c3dfa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520234006.291c3dfa.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This patch silences the default i386 boot by putting a lot of development
> >  related printks under KERN_DEBUG loglevel, allowing the normal chatty mode
> >  to be turned on by using the 'debug' kernel parameter.
> 
> I think I like it chatty.  Turning this stuff off by default makes kernel
> developers' lives that little bit harder.

Its too chatty these days. Like "APIC debug info hide real errors before that",
because log buffer is not big enough and scrollback is not enough.
Please take this one...
			Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

