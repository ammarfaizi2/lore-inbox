Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUDAH0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 02:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUDAH0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 02:26:36 -0500
Received: from gprs213-219.eurotel.cz ([160.218.213.219]:9088 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262579AbUDAH0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 02:26:34 -0500
Date: Thu, 1 Apr 2004 09:26:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] [PATCH 2.6]: suspend to disk only available if non-modular IDE
Message-ID: <20040401072623.GA224@elf.ucw.cz>
References: <200403282136.55435.arekm@pld-linux.org> <1080517040.2223.3.camel@laptop-linux.wpcb.org.au> <20040330201123.GE3084@openzaurus.ucw.cz> <1080772560.3081.0.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080772560.3081.0.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Applied to 2.4 and 2.6.
> > 
> > Bad idea. For swsusp2 the patch is bad because it can resume from 
> > after initrd (IIRC). For swsusp1 patch is bad
> > because it should be able to resume
> > from usb mass storage drive.
> 
> So long as the initrd doesn't mess our filesystems up, we should be
> okay, shouldn't we?

As long as we test it once a while, yes.

But if resume from initrd works there's no reason to disallow modular
IDE... and that was what patch did.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
