Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUDOEzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 00:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263730AbUDOEzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 00:55:23 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:19343 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S261689AbUDOEzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 00:55:20 -0400
Subject: Re: modules in 2.6 kernel - question for FAQ?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040415044452.GA2215@mars.ravnborg.org>
References: <200404142142.41137.arekm@pld-linux.org>
	 <1081993968.17782.112.camel@bach> <20040415044452.GA2215@mars.ravnborg.org>
Content-Type: text/plain
Message-Id: <1082004860.17780.143.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 14:54:20 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 14:44, Sam Ravnborg wrote:
> On Thu, Apr 15, 2004 at 11:52:48AM +1000, Rusty Russell wrote:
> > On Thu, 2004-04-15 at 05:42, Arkadiusz Miskiewicz wrote:
> > > insmod: error inserting './Intel537.ko': -1 Invalid module format
> > 
> > They didn't use -fno-common.  The patch which adds in the warning got
> > lost a while back.
> > 
> > Here's a new one...
> 
> Is it be possible to detect this during the modpost stage, or do they manage to
> avoid that in some way?
> I would rather see the error a bit earlier. Eventually depmod.
> Still your patch make relevance as a double check.

They can only do this if they're not using the kernel makefiles.  So I
don't really think it's a priority...

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

