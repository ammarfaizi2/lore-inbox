Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVLOWr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVLOWr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVLOWr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:47:56 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:60318 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751172AbVLOWr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:47:56 -0500
Date: Thu, 15 Dec 2005 14:48:01 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Jordan Crouse <jordan.crouse@amd.com>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       info-linux@ldcmail.amd.com
Subject: Re: Geode LX HW RNG Support
Message-ID: <20051215224801.GA20307@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20051215211248.GE11054@cosmic.amd.com> <20051215211423.GF11054@cosmic.amd.com> <20051215133917.3f0a5171.akpm@osdl.org> <20051215214432.GB14013@cosmic.amd.com> <20051215140622.53c37335.akpm@osdl.org> <43A1E91A.4060400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A1E91A.4060400@pobox.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 15 2005, at 17:07, Jeff Garzik was caught saying:
> Andrew Morton wrote:
> >"Jordan Crouse" <jordan.crouse@amd.com> wrote:
> >
> >>>Should all the Geode additions to hw_random.c be inside __i386__, like 
> >>>VIA?
> >>
> >>I thought that a early version did that and somebody took exception to 
> >>it, but I can't find any e-mails to that effect right now.  Obviously, 
> >>the defines are only useful when you have a Geode CPU (and thus a 
> >>x86_32), so if nobody complains, I think that would be fine.
> >
> >
> >Fair enough.  Please send an update sometime.
> >
> >We might as well do s/__i386__/X86_32/ throughout that file - bit pointless
> >but it's a little bit more idiomatic.
> 
> What about the rng rewrite recently posted?  Any opinions on that?
> 
> I lean towards applying it, long term, but IIRC there were problems that 
> prevented immediate merge.

Looking at the thread from my 2nd attempt, the main thing holding it back 
from -mm was splitting the VIA/AMD/Intel drivers into separate files but 
as is often the case, -ETOOMANYPROJECTS. Will try to get to it sometime 
early next year.

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

For what are your possessions but things you keep and guard for fear
you may need them tomorrow. - Khalil Gibran, "The Prophet"
