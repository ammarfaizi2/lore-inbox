Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVCCJgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVCCJgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVCCJe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:34:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:51871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261764AbVCCJcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:32:42 -0500
Date: Thu, 3 Mar 2005 01:32:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: miklos@szeredi.hu, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [request for inclusion] Filesystem in Userspace
Message-Id: <20050303013203.245c8833.akpm@osdl.org>
In-Reply-To: <16934.54647.354607.902748@alkaid.it.uu.se>
References: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu>
	<20050302123123.3d528d05.akpm@osdl.org>
	<16934.54647.354607.902748@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> Andrew Morton writes:
>  > Miklos Szeredi <miklos@szeredi.hu> wrote:
>  > >
>  > > Do you have any objections to merging FUSE in mainline kernel?
>  > 
>  > I was planning on sending FUSE into Linus in a week or two.  That and
>  > cpusets are the notable features which are 2.6.12 candidates.
>  > 
>  > - crashdump seems permanently not-quite-ready
>  > 
>  > - perfctr works fine, but is rather deadlocked because it is
>  >   similar-to-but-different-from ia64's perfmon, and might not be suitable
>  >   for ppc64 (although things have gone quiet on the latter front).
> 
> perfctr has one API update pending, and then the API should be
> in it final-ish form. David Gibson at IBM has done a ppc64 port,
> which is about ready to be merged, and someone else has just
> started working on a mips port.
> 

That sounds good.  Where do we stand now with ia64?  Do we just end up
agreeing to differ?

