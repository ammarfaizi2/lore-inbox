Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTF0LsC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 07:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTF0LsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 07:48:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25359 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264256AbTF0LqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 07:46:01 -0400
Date: Thu, 26 Jun 2003 14:09:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Fauchon <olivier.fauchon@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suspend on ram ... LCD & backlight restore problem.
Message-ID: <20030626120924.GB476@zaurus.ucw.cz>
References: <3EF937FA.1090300@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF937FA.1090300@free.fr>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I tried suspend on ram on my VAio FX 801 & kernel 2.5.69,
> 
> with echo "3" > /proc/acpi/sleep
> 
> That works great, system goes to sleep and red light blinking.
> 
> But When i try to resume, i can see the display coming back for a few 
> milliseconds, and then LCD goes black & backlight turns off.

You are hitting hard-to-solve "how to restore
video state" problem. Perhaps you can get
xfree to restore it for you...

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

