Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUKXWiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUKXWiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 17:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbUKXWiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 17:38:00 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:56251 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262794AbUKXWhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:37:05 -0500
Subject: Re: Suspend 2 merge: 10/51: Exports for suspend built as modules.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041124144429.GA18515@elte.hu>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101294252.5805.228.camel@desktop.cunninghams>
	 <20041124144429.GA18515@elte.hu>
Content-Type: text/plain
Message-Id: <1101329204.3895.2.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 07:46:44 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 01:44, Ingo Molnar wrote:
> * Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> 
> > New exports for suspend. I've cut them down some as a result of the
> > last review, but could perhaps do more? Would people prefer to see a
> > single struct wrapping exported functions?
> 
> > --- 400-exports-old/kernel/sched.c	2004-11-06 09:23:53.364977120 +1100
> > +++ 400-exports-new/kernel/sched.c	2004-11-06 09:23:56.627481144 +1100
> > @@ -3798,6 +3798,7 @@
> >  
> >  	read_unlock(&tasklist_lock);
> >  }
> > +EXPORT_SYMBOL(show_state);
> 
> this one is ok i think, but make it EXPORT_SYMBOL_GPL() please.

Okay. Will do.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

