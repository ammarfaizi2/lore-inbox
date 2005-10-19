Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVJSLwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVJSLwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVJSLwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:52:23 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:10916 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750789AbVJSLwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:52:22 -0400
Date: Wed, 19 Oct 2005 07:51:47 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Christoph Hellwig <hch@infradead.org>
cc: Lee Revell <rlrevell@joe-job.com>, Mark Knecht <markknecht@gmail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       rmk@arm.linux.org.uk, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi_error thread exits in TASK_INTERRUPTIBLE state.
In-Reply-To: <20051019113131.GA30553@infradead.org>
Message-ID: <Pine.LNX.4.58.0510190751070.20634@localhost.localdomain>
References: <5bdc1c8b0510181402o2d9badb0sd18012cf7ff2a329@mail.gmail.com>
 <1129693423.8910.54.camel@mindpipe> <1129695564.8910.64.camel@mindpipe>
 <Pine.LNX.4.58.0510190300010.20634@localhost.localdomain>
 <Pine.LNX.4.58.0510190349590.20634@localhost.localdomain>
 <20051019113131.GA30553@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Oct 2005, Christoph Hellwig wrote:

> > +	/*
> > +	 * There's a good chance that the loop will exit in the
> > +	 * TASK_INTERRUPTIBLE state.
> > +	 */
> > +	__set_current_state(TASK_RUNNING);
>
> no need to comment the obvious.
>

So, should I resend the patch without the comment?

-- Steve

