Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUDOEhA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 00:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbUDOEhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 00:37:00 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:17277 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261690AbUDOEg7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 00:36:59 -0400
Date: Thu, 15 Apr 2004 06:44:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: modules in 2.6 kernel - question for FAQ?
Message-ID: <20040415044452.GA2215@mars.ravnborg.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Arkadiusz Miskiewicz <arekm@pld-linux.org>,
	Andrew Morton <akpm@osdl.org>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200404142142.41137.arekm@pld-linux.org> <1081993968.17782.112.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081993968.17782.112.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 11:52:48AM +1000, Rusty Russell wrote:
> On Thu, 2004-04-15 at 05:42, Arkadiusz Miskiewicz wrote:
> > insmod: error inserting './Intel537.ko': -1 Invalid module format
> 
> They didn't use -fno-common.  The patch which adds in the warning got
> lost a while back.
> 
> Here's a new one...

Is it be possible to detect this during the modpost stage, or do they manage to
avoid that in some way?
I would rather see the error a bit earlier. Eventually depmod.
Still your patch make relevance as a double check.

	Sam
