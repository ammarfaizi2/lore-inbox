Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270435AbTGSDZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 23:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270447AbTGSDZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 23:25:10 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:19847 "EHLO
	hera.eugeneteo.net") by vger.kernel.org with ESMTP id S270435AbTGSDZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 23:25:07 -0400
Date: Sat, 19 Jul 2003 11:39:59 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] O7int for interactivity
Message-ID: <20030719033959.GD10120@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <200307190210.49687.kernel@kolivas.org> <1058568811.602.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058568811.602.1.camel@teapot.felipe-alfaro.com>
X-Operating-System: Linux 2.6.0-test1-mm1+o6.1int
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Felipe Alfaro Solana">
> On Fri, 2003-07-18 at 18:10, Con Kolivas wrote:
> > Here is an update to my Oint patches for 2.5/6 interactivity. Note I will be 
> > away for a week so bash away and abuse this one lots and when I get back I can 
> > see what else needs doing. Note I posted a preview earlier but this is the formal
> > O7 patch (check the datestamp which people hate in the naming of my patches).
> > I know this is turning into a marathon effort but... as you're all probably aware
> > there is nothing simple about tuning this beast. Thanks to all the testers and
> > people commenting; keep it coming please.
> 
> Feels pretty nice here... X still feels a little "heavy" and slow when
> forcing Evolution to repaint its main window. Anyways, this seems to be
> on the right track.

I was telling Con that when I first trying the O7int patch, after
a series of activities (mutt, xmms, licq, firebird, blah, and blah),
i experienced high loads (2.00+, 3.00+ - that is pretty high for me
already, considering the reasonably high-end laptop i am using). xmms
seem to starved. doing top, i discovered that most, if not all the
X apps that i am running at the moment are in low priority, that is
18-25 at least. compiling kernel, listening to mp3s, typing something
seems difficult. i couldn't deduce what has really gone wrong. i have
not experience this before (O6.1int, and below).

Any idea?

Eugene
