Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269645AbUINSUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269645AbUINSUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269649AbUINSSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:18:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:19179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269639AbUINSNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:13:23 -0400
Date: Tue, 14 Sep 2004 11:13:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Vincent Hanquez <tab@snarc.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BSD Jail LSM
Message-ID: <20040914111314.U1973@build.pdx.osdl.net>
References: <1094847705.2188.94.camel@serge.austin.ibm.com> <1094847787.2188.101.camel@serge.austin.ibm.com> <1094844708.18107.5.camel@localhost.localdomain> <20040912233342.GA12097@escher.cs.wm.edu> <1095072996.14355.12.camel@localhost.localdomain> <1095117605.2350.11.camel@serge.austin.ibm.com> <20040913235828.GA7212@snarc.org> <20040914140407.GA21110@escher.cs.wm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040914140407.GA21110@escher.cs.wm.edu>; from serue@us.ibm.com on Tue, Sep 14, 2004 at 10:04:07AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> > Do you really need all thoses macros ?
> > It seems to me that's too much macros for stuff which are easy
> > to write and to understand.
> 
> the _security macros are there because I'm working with 3 ways of stacking
> security modules which share the ->security fields, where these can
> turn into static inlines.  Being able to just change the defines has
> been very helpful.
> 
> I guess I've grown used to seeing them so I didn't even notice.  I
> will send out a new patch with the #defines removed tomorrow if that's
> deemed helpful.

For now they are fine as they are.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
