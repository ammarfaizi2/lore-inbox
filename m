Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVDHWyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVDHWyF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVDHWyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:54:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53237 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261181AbVDHWxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:53:43 -0400
Subject: RE: [PATCH] Priority Lists for the RT mutex
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A02F64643@orsmsx407>
References: <F989B1573A3A644BAB3920FBECA4D25A02F64643@orsmsx407>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113000816.26295.26.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 Apr 2005 15:53:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 14:25, Perez-Gonzalez, Inaky wrote:
> I concur with Daniel. If we can decide how to deal with that (toss
> one out, keep one, merge them, whatever), we could reuse all the user
> space glue that is the hardest part to get right.

	I have a preference to the Real-Time PI , but that's just cause I've
worked with it more. Ingo's really the one that should be make those
choices though, since he has the biggest influence over what goes into
sched.c ..

> Current tip of development has some issues with conditional variables
> and broadcasts (requeue stuff) that I need to sink my teeth in. Joe
> Korty is fixing up a lot of corner cases I wasn't catching, but 
> other than that is doing fine.

You try to get out, and they suck you right back in.

> How long ago since you saw it? I also implemented the futex redirection
> stuff we discussed some months ago.

It's been a while since I've seen the fusyn scheduler changes. I have
the curernt fusyn CVS, I'll take a look at it.

Daniel


