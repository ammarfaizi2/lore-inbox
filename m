Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWEAXMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWEAXMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWEAXMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:12:30 -0400
Received: from fmr18.intel.com ([134.134.136.17]:31683 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932319AbWEAXM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:12:29 -0400
Date: Mon, 1 May 2006 16:11:26 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Martin Bligh <mbligh@google.com>
Cc: Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
Message-ID: <20060501231126.GH32385@goober>
References: <20060427014141.06b88072.akpm@osdl.org> <p73vesv727b.fsf@bragg.suse.de> <20060427121930.2c3591e0.akpm@osdl.org> <200604272126.30683.ak@suse.de> <20060427124452.432ad80d.rdunlap@xenotime.net> <20060427131100.05970d65.akpm@osdl.org> <44512B61.4040000@google.com> <445220AB.9000606@grupopie.com> <20060501212051.GG32385@goober> <44567F09.9080902@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44567F09.9080902@google.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 02:35:05PM -0700, Martin Bligh wrote:
> Valerie Henson wrote:
> >
> >Honestly, the security nightmare begins with the compile.  A patch to
> >the build system can result in arbitrarily insecure commands being run
> >during the compile - way easier than doing something that affects the
> >compiled kernel.  A machine doing automatic compiles of untrusted
> >patches should be viewed as completely sacrificial from the beginning.
> 
> True - good point ... but it's easier to chroot jail. And I'm lazy ;-)
> If anyone wants to make autotest (http://test.kernel.org/autotest)
> support some sort of virtual boot via creating a UML instance or
> something, that'd be great. But I won't hold my breath ;-)

I think you should do this, security issues be darned.  Just wanted to
point out where the real concern was.  And thanks in advance!

-VAL
