Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbUE1NYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUE1NYE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUE1NYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:24:03 -0400
Received: from colin2.muc.de ([193.149.48.15]:9990 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262909AbUE1NX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:23:59 -0400
Date: 28 May 2004 15:23:58 +0200
Date: Fri, 28 May 2004 15:23:58 +0200
From: Andi Kleen <ak@muc.de>
To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrey Panin <pazke@donpac.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] 2.6.7-rc1-mm1, Simplify DMI matching data
Message-ID: <20040528132358.GA78847@colin2.muc.de>
References: <20Oc4-HT-25@gated-at.bofh.it> <m3zn7su4lv.fsf@averell.firstfloor.org> <20040528125447.GB11265@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528125447.GB11265@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 01:54:47PM +0100, Dave Jones wrote:
> On Fri, May 28, 2004 at 02:18:52PM +0200, Andi Kleen wrote:
> 
>  > > simplify DMI blacklist table by removing the need to fill
>  > > unused slots with NO_MATCH macro.
>  > 
>  > Can you please delay that patch for 2.7?
>  > 2.6 is for bug fixes, not for cleanups.
>  > 
>  > There are large third party patchkits for DMI and "cleaning up" 
>  > the format will just cause lots of rejects and pain. 
> 
> Alternatively, those third parties could get their act
> together and submit those patches back upstream.

Often this is not the best thing to do - e.g. for upstream it is 
better to track down the bugs and try to fix them, even if that
takes a long time or find some other cleaner solution that doesn't
involve blacklisting. For a third party there are often time constraints 
(e.g. for a release) where there is no time to track down everything and 
blacklisting has to be more extensively used.

My point stays that kernel interfaces should stay stable in the stable
series as far as possible (= unless terminally broken, but that's
clearly not the case here).  If you feel the need to clean up
something better wait for the unstable series.

-Andi
