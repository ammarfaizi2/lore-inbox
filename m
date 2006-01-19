Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161255AbWASP5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161255AbWASP5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWASP5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:57:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25194 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161255AbWASP5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:57:52 -0500
Date: Thu, 19 Jan 2006 16:59:33 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       David Woodhouse <dwmw2@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch removed from -mm tree
Message-ID: <20060119155933.GX4213@suse.de>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net> <1137648119.30084.94.camel@localhost.localdomain> <20060119171708.7f856b42.sfr@canb.auug.org.au> <1137664692.8471.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137664692.8471.21.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19 2006, Alan Cox wrote:
> On Iau, 2006-01-19 at 17:17 +1100, Stephen Rothwell wrote:
> > Documentation/CodingStyle says:
> > 
> > The limit on the length of lines is 80 columns and this is a hard limit.
> 
> Its so hard nobody follows it because in many places the results as Dave
> correctly points out are just stupid.
> 
> Linux 2.6.16-rc1
> 	Number of files matching *.[c|h]	: 15732
> 	Number with lines exceeding 80 columns	: 6931
> 	As a percentage				: 44%
> 
> Fix the CodingStyle document instead

89% of all statistics are bogus, right? In those files, how many lines
are correctly wrapped even if some are > 80 chars?

I think the CodingStyle suggestion of 80 chars is just fine. I try to
stay within that, and I mostly succeed. The occasional over-the-line is
far better than advocation >> 80 chars per line imho.

-- 
Jens Axboe

