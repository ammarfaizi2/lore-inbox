Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWG2Qv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWG2Qv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 12:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWG2Qv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 12:51:58 -0400
Received: from ns.suse.de ([195.135.220.2]:48068 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751302AbWG2Qv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 12:51:57 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] i386: Do backtrace fallback too
Date: Sat, 29 Jul 2006 18:52:11 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200607290300.k6T306Fc003168@hera.kernel.org> <200607291835.54379.ak@suse.de> <20060729164238.GB16946@redhat.com>
In-Reply-To: <20060729164238.GB16946@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607291852.12353.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 July 2006 18:42, Dave Jones wrote:
> On Sat, Jul 29, 2006 at 06:35:54PM +0200, Andi Kleen wrote:
>  > >  >  arch/i386/kernel/traps.c |   17 ++++++++++++++---
>  > >  >  1 files changed, 14 insertions(+), 3 deletions(-)
>  > >
>  > > Hmm, this breaks the build for me..
>  >
>  > Hmm, it definitely builds here. Ah do you have UNWIND_INFO
>  > disabled?
>
> That was with it enabled iirc, I'll double check and do another
> build later (though you may want to look at Erik Mouw's reply)

Ok I fixed it now. Patch with some other patches will come soon.

-Andi
