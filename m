Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268801AbTBZQVg>; Wed, 26 Feb 2003 11:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268802AbTBZQVg>; Wed, 26 Feb 2003 11:21:36 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:52423 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S268801AbTBZQVf>; Wed, 26 Feb 2003 11:21:35 -0500
Date: Wed, 26 Feb 2003 16:31:54 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Enabling L2 cache for overdrive CPUs.
Message-ID: <20030226163154.GB15163@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mikael Pettersson <mikpe@user.it.uu.se>,
	linux-kernel@vger.kernel.org
References: <200302261349.h1QDn0Bh002816@deviant.impure.org.uk> <15964.52883.370949.237446@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15964.52883.370949.237446@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 03:26:27PM +0100, Mikael Pettersson wrote:

 > Ugh. Is this for the PII overdrive for PPro socket or what?

Celerons iirc. I got a mail from someone annoyed at the
binary only module that powerleap gave him to do this.
I just disassembled it and turned it back to C.

 > Seems awfully dangerous to have a __setup() clobber MSRs without
 > checking the cpuid first. 
 > Shouldn't this be in the CPU detection/quirks code instead?
 > It already contains stuff similar to this.

That is another option that could be done, yes..

        Dave

