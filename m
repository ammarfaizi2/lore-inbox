Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbTFBTAv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 15:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264840AbTFBTAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 15:00:51 -0400
Received: from www.wireboard.com ([216.151.155.101]:60638 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id S264826AbTFBTAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 15:00:50 -0400
To: joe briggs <jbriggs@briggsmedia.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: impact of Athlon's slower front-side-bus (FSB)
References: <200306020947.44520.jbriggs@briggsmedia.com>
	<1054565258.7494.34.camel@dhcp22.swansea.linux.org.uk>
	<200306021436.24029.jbriggs@briggsmedia.com>
From: Doug McNaught <doug@mcnaught.org>
Date: 02 Jun 2003 15:14:10 -0400
In-Reply-To: joe briggs's message of "Mon, 2 Jun 2003 14:36:24 -0400"
Message-ID: <m3brxgl2bh.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joe briggs <jbriggs@briggsmedia.com> writes:

> Can I do this with the 2.4.19 kernel (debian)?  The cards in question are quad 
> bt878 frame grabbers. How specifically can I tie a particular bt878 to a 
> particular processor on the dual athlon platform?  

I don't think so but building a kernel package with an -ac kernel (or
any other version) is dead easy on Debian--don't let that stop you.

> One last question, given the slow FSB and the fact that 2 uP's are
> groping for the same memory space and that each bt878 is dma'ing its
> data to memory, is the SMP still a better idea than uni-processor?

If there's any way to actually test both configurations, I'd do
so--there are enough variables here that random handwaving arguments
aren't going to be really useful.

-Doug
