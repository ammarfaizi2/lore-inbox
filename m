Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbTIPJiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 05:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbTIPJiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 05:38:12 -0400
Received: from gprs149-34.eurotel.cz ([160.218.149.34]:10624 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261816AbTIPJiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 05:38:09 -0400
Date: Tue, 16 Sep 2003 11:37:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nicolae Mihalache <mache@abcpages.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test4 problems: suspend and touchpad
Message-ID: <20030916093752.GB397@elf.ucw.cz>
References: <Pine.LNX.4.33.0309150949270.950-100000@localhost.localdomain> <3F662322.9060205@abcpages.com> <3F66310E.3000209@abcpages.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F66310E.3000209@abcpages.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>It does not. Could you please try removing the module before you 
> >>suspend?
> >
> >Yes, removing and readding the module does the trick.
> >Unfortunately I've seen that something else does not work after 
> >resume: my USB mouse.
> >But for some reason I can not remove the usbcore module, the kernel 
> >says it's in use. 
> 
> I see that the mouse is not even powered. It's an optical mouse and the 
> light stays switched off.

USB suspend/resume does not currently work. It worked for uhci in
-test3, but it never worked for ohci.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
