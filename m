Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270724AbTGUVRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270729AbTGUVRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:17:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28932 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270724AbTGUVRA (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 21 Jul 2003 17:17:00 -0400
Date: Mon, 21 Jul 2003 23:31:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: linux-kernel@vger.redhat.com
Subject: Re: swsusp / 2.6.0-test1
Message-ID: <20030721213141.GF436@elf.ucw.cz>
References: <1058805510.15585.7.camel@simulacron> <20030721193615.GB473@elf.ucw.cz> <3F1C5C26.10607@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1C5C26.10607@kolumbus.fi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>swsusp is working fine, but mplayer
> >>in sdl and xv output mode displays a blank
> >>screen after a resume. 
> >>   
> >You probably need to write suspend/resume support for your card.
> >
> 
> Just wondering what kind of support for suspend/resume is "enough", say 
> for video cards? Surely not the pci configuration space, you need to 
> restore video mode, color maps, gfx engine state etc etc...what about 
> frame buffer contents on card? Probably yes. Sounds like a lot of code, 
> and different thing for every possible video card. Is there some general 
> guidance here? Is drivers/video soon bloating with tons of 
> suspend/resume code? I hope I am wrong :)

I'm not sure if you are wrong. If you switch  to non-graphics console,
that may save some code, but...

BTW vger.redhat.com, what is that?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
