Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTHYOgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 10:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbTHYOgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 10:36:15 -0400
Received: from main.gmane.org ([80.91.224.249]:8338 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261783AbTHYOgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 10:36:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] Nick's scheduler policy v7
Date: Mon, 25 Aug 2003 16:36:12 +0200
Message-ID: <yw1xd6etrehv.fsf@users.sourceforge.net>
References: <3F48B12F.4070001@cyberone.com.au> <29760000.1061744102@[10.10.2.4]>
 <3F497BB6.90100@cyberone.com.au> <3F49E7D1.4000309@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:mDa3tMi55f7J9QvpBy9X/yq7Pdw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> writes:

> This one has a few changes. Children now get a priority boost
> on fork, and parents retain more priority after forking a child,
> however exiting CPU hogs will now penalise parents a bit.
>
> Timeslice scaling was tweaked a bit. Oh and remember raising X's
> priority should _help_ interactivity with this patch, and IMO is
> not an unreasonable thing to be doing.
>
> Please test. I'm not getting enough feedback!

OK, if you test my software.

Seriously, though, it seems OK at first glance.  I can't reproduce the
XEmacs problems I had with Con's recent versions.  I'll have to run it
for a while and see what it seems like.

-- 
Måns Rullgård
mru@users.sf.net

