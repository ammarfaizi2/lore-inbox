Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWHUAtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWHUAtW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWHUAtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:49:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18052 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932400AbWHUAtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:49:21 -0400
Date: Sun, 20 Aug 2006 21:51:11 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce CONFIG_BINFMT_ELF_AOUT
Message-ID: <20060821005111.GB4451@dmt>
References: <20060819232556.GA16617@openwall.com> <20060821001628.GC2861@dmt> <20060821003321.GA22541@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821003321.GA22541@openwall.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Solar,

On Mon, Aug 21, 2006 at 04:33:21AM +0400, Solar Designer wrote:
> On Sun, Aug 20, 2006 at 09:16:29PM -0300, Marcelo Tosatti wrote:
> > I dislike this change.
> 
> Which one?  The introduction of CONFIG_BINFMT_ELF_AOUT or having it and
> CONFIG_BINFMT_AOUT disabled by default - or both?

Both actually. Its not 2.4 material at this point in time.

> > We had this discussion before, didnt we?
> 
> Yes, you had proposed the same thing that Willy did - to introduce
> CONFIG_BINFMT_ELF_AOUT but have it default to enabled, and to not
> change any other defaults.  I simply haven't had the time (nor
> motivation since this almost defeats the purpose of the patch) to
> re-arrange the patch for that yet, so I decided to post what I readily
> had first for public comment.  I should have mentioned this past
> discussion in my posting, sorry.

No problem.

To be sincere, I'd prefer to see fixes for potential security bugs in
the a.out code rather than making it optional (so, it appears that I've
got a different opinion now).

> Thanks,

Thank you for resubmitting your patches...

