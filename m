Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVERPFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVERPFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVERPFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:05:31 -0400
Received: from web8506.mail.in.yahoo.com ([202.43.219.168]:15525 "HELO
	web8506.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S262265AbVERPCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:02:13 -0400
Message-ID: <20050518150200.88195.qmail@web8506.mail.in.yahoo.com>
Date: Wed, 18 May 2005 16:02:00 +0100 (BST)
From: Dinesh Ahuja <mdlinux7@yahoo.co.in>
Subject: Re: Share Wait Queue between different modules ?
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Steven for answer.

Could please tell me know how to share wait queue
between different modules and where will be pratical
implementation of that case.

Regards
Dinesh

--- Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 2005-05-16 at 16:11 +0100, Dinesh Ahuja
> wrote:
> > Hi ,
> > 
> > Just trying to explore a situation where different
> > modules may need to share same wait queues. Could
> > anyone tell me the pratical situation where we
> need to
> > have above mentioned situation ?
> > 
> 
> Have an example of this situation?
> 
> > Please clarify me on below point : 
> > We say that kernel stack is very much limited
> around
> > 8KB.
> > Does all the running processes share this stack or
> > each process has 8KB of the space which process
> can
> > access when it is running in kernel mode.
> > 
> 
> The later.  Each process has its own kernel stack
> when in kernel mode.
> 
> > Sharing wait queues will be difficult if the
> kernel
> > space is 8KB for all the ready processes because
> then
> > the no of wait_queue_t elements which can be added
> > will be limited.
> > 
> 
> As mentioned above, each process has its own kernel
> stack.
> 
> 
> -- Steve
> 
> 
> 

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
