Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTLJWSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 17:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTLJWSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 17:18:30 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:62908 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264137AbTLJWS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 17:18:28 -0500
Date: Wed, 10 Dec 2003 14:18:00 -0800
From: Larry McVoy <lm@bitmover.com>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031210221800.GM6896@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Kendall Bennett <KendallB@scitechsoft.com>,
	Linus Torvalds <torvalds@osdl.org>,
	'Andre Hedrick' <andre@linux-ide.org>,
	'Arjan van de Ven' <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
	linux-kernel@vger.kernel.org
References: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com> <3FD7081D.31093.61FCFA36@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD7081D.31093.61FCFA36@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 11:48:45AM -0800, Kendall Bennett wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > In fact, a user program written in 1991 is actually still likely
> > to run, if it doesn't do a lot of special things. So user programs
> > really are a hell of a lot more insulated than kernel modules,
> > which have been known to break weekly. 
> 
> IMHO (and IANAL of course), it seems a bit tenuous to me the argument 
> that just because you deliberating break compatibility at the module 
> level on a regular basis, that they are automatically derived works. 

Not only that, I think the judge would have something to say about the 
fact that the modules interface is delibrately changed all the time 
with stated intent of breaking binary drivers.  In fact, Linus pointed
out his thoughts on what the judge would say:

    In fact, I will bet you that if the judge thinks that you tried to
    use technicalities ("your honour, I didn't actually run the 'ln'
    program, instead of wrote a shell script for the _user_ to run the
    'ln' program for me"), that judge will just see that as admission
    of the fact that you _knew_ you were doing something bad.

Why is it that the judge wouldn't see the delibrate changing of the
interfaces, the EXPORT_GPL stuff, all of that as a way to delibrately
force something that wouldn't otherwise be a derived work into a 
derived work category?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
