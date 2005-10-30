Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVJ3LrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVJ3LrN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 06:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVJ3LrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 06:47:13 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31188 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932097AbVJ3LrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 06:47:13 -0500
Date: Sun, 30 Oct 2005 12:46:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
Subject: Re: [RFC][PATCH 4/6] swsusp: move swap check out of swsusp_suspend
Message-ID: <20051030114658.GG16684@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <200510292236.47960.rjw@sisk.pl> <20051029232134.GG14209@elf.ucw.cz> <200510301340.20959.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510301340.20959.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This is a non-essential step making the next patch possible.  No functionality
> > > changes.
> > 
> > If you can push this before 3/6, that would be nice.
> 
> Sure.  I think I'll send the two patches you have already acked and this one
> to Andrew as a separate series.  Then I'll get back to the 3/6 etc.

Splitting swsusp.c into swsusp.c and swap.c looked nice, too, btw. We
may finally get rid of "swsusp" name :-). But, in the long term, I'd
like to see swap reading/writing support removed from kernel. That
2.8.0 or something, through...
								Pavel
-- 
Thanks, Sharp!
