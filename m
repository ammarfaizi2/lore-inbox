Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbRFZWgE>; Tue, 26 Jun 2001 18:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbRFZWfn>; Tue, 26 Jun 2001 18:35:43 -0400
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:21754 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S265134AbRFZWfd>; Tue, 26 Jun 2001 18:35:33 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: User space zero copy HOWTO?
In-Reply-To: <200106260243.f5Q2hfJ177651@saturn.cs.uml.edu>
From: Camm Maguire <camm@enhanced.com>
Date: 26 Jun 2001 18:35:28 -0400
In-Reply-To: "Albert D. Cahalan"'s message of "Mon, 25 Jun 2001 22:43:41 -0400 (EDT)"
Message-ID: <54d77qg98v.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, and thanks for this.  If I recall, there is some facility
for this in the tulip cards too, no?  Can one get any benefit with
100Mbps, or is the copy too fast anyway?  Is the source code for Tux
available somewhere?  This is probably the best bet.  It seems as
though the source for X15 is not available.  Any pointers
appreciated.  I'm investigating implementing something like this for
the lam MPI libs.

Take care,

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> > Greetings!  Is there any faq/sample code somewhere showing how to get
> > zero copy tcp/ip with kernel 2.4, and what special hardware if any is
> > required?  Any information most appreciated.  Kindly cc me directly.
> 
> The hardware must do scatter-gather and IP checksuming.
> 
> The Alteon-based gigabit cards do this well. They are fully
> programmable, and even have a developer's kit that can be used
> to implement non-IP message passing protocols.
> 
> 
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
