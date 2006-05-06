Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWEFEQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWEFEQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 00:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWEFEQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 00:16:56 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:29870 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S932431AbWEFEQz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 00:16:55 -0400
To: Andi Kleen <ak@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Bugs aren't features: X86_FEATURE_FXSAVE_LEAK
References: <445B7EF0.6090708@zytor.com> <p733bfo5ol1.fsf@bragg.suse.de>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 06 May 2006 06:16:54 +0200
In-Reply-To: <p733bfo5ol1.fsf@bragg.suse.de>
Message-ID: <m3iroju6rt.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > The recent fix for the AMD FXSAVE information leak had a problematic
> > side effect.  It introduced an entry in the x86 features vector which
> > is a bug, not a feature.
> 
> It's a non issue because it affects all AMD CPUs (except K5/K6).
> You'll never find a system where only some CPUs have this problem.

I have a dual CPU system (Tyan Tomcat 1564D) where only one CPU is
reported to have the F00F bug (iirc).  So yes, there can be
SMP-systems where the CPU's have different bugs.

    /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
