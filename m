Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVHIPlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVHIPlt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVHIPlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:41:49 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:50820 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964825AbVHIPlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:41:49 -0400
Subject: Re: Soft lockup in e100 driver ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <20050809143705.GM22165@mea-ext.zmailer.org>
References: <20050809133647.GK22165@mea-ext.zmailer.org>
	 <9a87484905080906556d9f531c@mail.gmail.com>
	 <20050809143705.GM22165@mea-ext.zmailer.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 09 Aug 2005 11:41:40 -0400
Message-Id: <1123602100.18332.174.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 17:37 +0300, Matti Aarnio wrote:
> On Tue, Aug 09, 2005 at 03:55:49PM +0200, Jesper Juhl wrote:
> > On 8/9/05, Matti Aarnio <matti.aarnio@zmailer.org> wrote:
> > > Running very recent Fedora Core Development kernel I can following
> > > soft-oops..   ( 2.6.12-1.1455_FC5smp )
> > > 
> > Various patches to the e100 driver have been merged since 2.6.12.1
> > (which is ~1.5months old), so it would make sense to try a more recent
> > kernel like 2.6.13-rc6, 2.6.13-rc6-git1 or 2.6.13-rc5-mm1 and see if
> > you can still reproduce the problem with those.
> 
> The kernel in question is less than 3 days old RedHat Fedora Core
> Development kernel with baseline as:
>   * Sun Aug 07 2005 Dave Jones <davej@redhat.com>
>     - 2.6.13-rc5-git4
> 
> Those merges have not helped.

Matti,

I believe Fedora must have added Ingo's soft lockup detect code.  I've
made additions to this code as well. Could you point me to a link that I
could download this kernel source.  No rpm's or packagemanagers please.
Just a tarball would be fine.

Thanks,

-- Steve


