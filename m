Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264814AbSKJLlN>; Sun, 10 Nov 2002 06:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264816AbSKJLlM>; Sun, 10 Nov 2002 06:41:12 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1796 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264814AbSKJLlL>;
	Sun, 10 Nov 2002 06:41:11 -0500
Date: Thu, 7 Nov 2002 18:39:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <shawnstarr@mobile.rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call to rewrite swsusp
Message-ID: <20021107173948.GB773@elf.ucw.cz>
References: <200211041531.gA4FVYWp026000@BlackBerry.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211041531.gA4FVYWp026000@BlackBerry.NET>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Talking with some people last night it seems we need to redo the
> swsusp (driver). From what I've been told and have seen (from the
> code) it doesn't talk to the generic subsystems (like block layer,
> network layer etc). From talks with some kernel developers, they
> tell me we would have to modify all the drivers to properly handle
> system suspends. Is it not APM/ACPI's job to bring down the system
> to a stable state when suspending the machine?

> The swsusp should be asking all the generic subsystems. When the
> machine is about to be suspended it should flush any read/write
> buffers, stop processing packets and other things.

> Am I totally wrong on this? :-)

Yes.
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
