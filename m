Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVLOWHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVLOWHd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVLOWHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:07:33 -0500
Received: from mail.dvmed.net ([216.237.124.58]:5346 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751152AbVLOWHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:07:32 -0500
Message-ID: <43A1E91A.4060400@pobox.com>
Date: Thu, 15 Dec 2005 17:07:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jordan Crouse <jordan.crouse@amd.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, info-linux@ldcmail.amd.com
Subject: Re: Geode LX HW RNG Support
References: <20051215211248.GE11054@cosmic.amd.com>	<20051215211423.GF11054@cosmic.amd.com>	<20051215133917.3f0a5171.akpm@osdl.org>	<20051215214432.GB14013@cosmic.amd.com> <20051215140622.53c37335.akpm@osdl.org>
In-Reply-To: <20051215140622.53c37335.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andrew Morton wrote: > "Jordan Crouse"
	<jordan.crouse@amd.com> wrote: > >>>Should all the Geode additions to
	hw_random.c be inside __i386__, like VIA? >> >>I thought that a early
	version did that and somebody took exception to >>it, but I can't find
	any e-mails to that effect right now. Obviously, >>the defines are only
	useful when you have a Geode CPU (and thus a x86_32), >>so if nobody
	complains, I think that would be fine. > > > Fair enough. Please send
	an update sometime. > > We might as well do s/__i386__/X86_32/
	throughout that file - bit pointless > but it's a little bit more
	idiomatic. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Jordan Crouse" <jordan.crouse@amd.com> wrote:
> 
>>>Should all the Geode additions to hw_random.c be inside __i386__, like VIA?
>>
>>I thought that a early version did that and somebody took exception to 
>>it, but I can't find any e-mails to that effect right now.  Obviously, 
>>the defines are only useful when you have a Geode CPU (and thus a x86_32), 
>>so if nobody complains, I think that would be fine.
> 
> 
> Fair enough.  Please send an update sometime.
> 
> We might as well do s/__i386__/X86_32/ throughout that file - bit pointless
> but it's a little bit more idiomatic.

What about the rng rewrite recently posted?  Any opinions on that?

I lean towards applying it, long term, but IIRC there were problems that 
prevented immediate merge.

	Jeff



