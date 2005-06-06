Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVFFTo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVFFTo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVFFTo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:44:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26804 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261643AbVFFTov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:44:51 -0400
Date: Mon, 6 Jun 2005 21:44:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Advices for a lcd driver design. (suite)
Message-ID: <20050606194437.GB3155@elf.ucw.cz>
References: <20050606183854.43545.qmail@web25804.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606183854.43545.qmail@web25804.mail.ukl.yahoo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 
> I posted an email 1 month ago because I was looking for advices to design
> a driver for a lcd device (128x64 pixels) with a t6963c controller.

Ugh, whats wrong with standard handling via framebuffer?

> I have finally choosen a console implementation to interact with the lcd. It
> allows me to reuse code that deals with escape character or to start a getty on
> it. Unfortunately this implemenatation doens't support lcd's graphical mode.
> So I wrote another small driver that can be accessed through "/dev/lcd". It
> drives the lcd only in graphical mode. That means that a "echo foo > /dev/lcd"
> command won't work as expected.

Look at framebuffer, that's what you want. See for example vesafb.

									Pavel
