Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271721AbTHRN2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 09:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271729AbTHRN2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 09:28:55 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:51107 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271721AbTHRN2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 09:28:53 -0400
Date: Mon, 18 Aug 2003 15:28:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Clock <clock@twibright.com>
Cc: kenton.groombridge@us.army.mil, linux-kernel@vger.kernel.org
Subject: Re: nforce2 lockups
Message-ID: <20030818132840.GC861@elf.ucw.cz>
References: <df962fdf9006.df9006df962f@us.army.mil> <20030815171521.A683@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815171521.A683@beton.cybernet.src>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't think the problem is the the IDE.  I have used a promise controller
> > and disabled the onboard IDE and still had lockups.  If you find a solution,
> > please let me know.  If I find one, I will do likewise.
> 
> It looks like the problem is in APIC. When you disable it, it vanishes.
> And, when you enable NMI watchdog, which is handled by APIC,

Another BIOS that dislikes APIC on when entering SMM mode? Perhaps
that board needs blacklist entry that panics box if APIC is activated?

									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
