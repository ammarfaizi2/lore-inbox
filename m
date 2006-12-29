Return-Path: <linux-kernel-owner+w=401wt.eu-S1753690AbWL2Jpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbWL2Jpu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 04:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbWL2Jpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 04:45:50 -0500
Received: from baikonur.stro.at ([213.239.196.228]:3725 "EHLO baikonur.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690AbWL2Jpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 04:45:49 -0500
X-Greylist: delayed 1350 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2006 04:45:49 EST
Date: Fri, 29 Dec 2006 10:23:14 +0100
From: maximilian attems <maks@sternwelten.at>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061229092314.GB24061@nancy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228193943.GC8940@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 28, 2006 at 11:21:21AM -0800, Linus Torvalds wrote:
>  > 
>  > 
>  > On Thu, 28 Dec 2006, Petri Kaukasoina wrote:
>  > > > me up), and that seems to show the corruption going way way back (ie going 
>  > > > back to Linux-2.6.5 at least, according to one tester).
>  > > 
>  > > That was a Fedora kernel. Has anyone seen the corruption in vanilla 2.6.18
>  > > (or older)?
>  > 
>  > Well, that was a really _old_ fedora kernel. I guarantee you it didn't 
>  > have the page throttling patches in it, those were written this summer. So 
>  > it would either have to be Fedora carrying around another patch that just 
>  > happens to result in the same corruption for _years_, or it's the same 
>  > bug.
> 
> The only notable VM patch in Fedora kernels of that vintage that I recall
> was Ingo's 4g/4g thing.
> 
> 		Dave

no the fedora 2.6.18 kernel is affected.
it carries the same -mm patches that Debian backported
for LSB 3.1 compliance.

-- 
maks

ps sorry for stripping cc, only downloaded that message raw.
