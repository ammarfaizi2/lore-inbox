Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269084AbUINOEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269084AbUINOEZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269092AbUINOEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:04:24 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:21704 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S269084AbUINOEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:04:23 -0400
Date: Tue, 14 Sep 2004 10:04:07 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Vincent Hanquez <tab@snarc.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BSD Jail LSM
Message-ID: <20040914140407.GA21110@escher.cs.wm.edu>
References: <1094847705.2188.94.camel@serge.austin.ibm.com> <1094847787.2188.101.camel@serge.austin.ibm.com> <1094844708.18107.5.camel@localhost.localdomain> <20040912233342.GA12097@escher.cs.wm.edu> <1095072996.14355.12.camel@localhost.localdomain> <1095117605.2350.11.camel@serge.austin.ibm.com> <20040913235828.GA7212@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913235828.GA7212@snarc.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Serge,
> 
> Do you really need all thoses macros ?
> It seems to me that's too much macros for stuff which are easy
> to write and to understand.

Hi,

the _security macros are there because I'm working with 3 ways of stacking
security modules which share the ->security fields, where these can
turn into static inlines.  Being able to just change the defines has
been very helpful.

I guess I've grown used to seeing them so I didn't even notice.  I
will send out a new patch with the #defines removed tomorrow if that's
deemed helpful.

thanks,
-serge
