Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUJGRAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUJGRAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUJGRAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:00:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:63180 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267438AbUJGQGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:06:47 -0400
Date: Thu, 7 Oct 2004 09:06:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@redhat.com>, serue@us.ibm.com, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] lsm: add bsdjail module
Message-ID: <20041007090645.U2357@build.pdx.osdl.net>
References: <20041007040859.GA17774@escher.cs.wm.edu> <Xine.LNX.4.44.0410070216130.2191-100000@thoron.boston.redhat.com> <20041006232208.505ccacd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041006232208.505ccacd.akpm@osdl.org>; from akpm@osdl.org on Wed, Oct 06, 2004 at 11:22:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> James Morris <jmorris@redhat.com> wrote:
> > On Thu, 7 Oct 2004, Serge E. Hallyn wrote:
> > 
> >  > Because it gives Linux a functionality like FreeBSD's jail and Solaris'
> >  > zones in an unobtrusive manner, without impacting users who don't wish
> >  > to use it  (except for the extra security_task_lookup function calls).
> > 
> >  Yes, as an LSM module, it can be configured out.  I think it's a good use
> >  of the LSM framework, and may be useful for people migrating to Linux from
> >  legacy Solaris and FreeBSD.
> 
> Sure, but that's a bit speculative for adding a feature to the mainline
> kernel.

Which feature are you concerned over, the additional hook or the
new module?  The module is a no-op for anybody who doesn't want it.
I can't vouch for the number of users of this module although I've seen
some positive feedback from users.  One nice bit is that it goes a way
towards helping vserver which does have quite a few users.  This module
really demonstrates one of the points of LSM...to support multiple
security models.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
