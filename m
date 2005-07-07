Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVGGTXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVGGTXB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVGGTUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:20:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26515 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261867AbVGGTUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:20:10 -0400
Date: Thu, 7 Jul 2005 21:19:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
Message-ID: <20050707191958.GC1435@elf.ucw.cz>
References: <11206164393426@foobar.com> <20050706082230.GF1412@elf.ucw.cz> <1120696047.4860.525.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120696047.4860.525.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is swsusp1 expected to be functional after these are applied? You
> > removed *some* of its hooks, but not all, so I'm confused.
> 
> I've been thinking about this some more and wondering whether I should
> just replace swsusp. I really don't want to step on your toes though.
> What would you like to see happen?

When/if suspend2 is merged and working, there's no reason to keep
swsusp around. So patches for removing swsusp1 are quite okay at the
end of series. OTOH it is one more patch for you to maintain, so... do
whatever you want.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
