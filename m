Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUASJwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 04:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbUASJwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 04:52:38 -0500
Received: from gprs214-240.eurotel.cz ([160.218.214.240]:6016 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264488AbUASJwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 04:52:36 -0500
Date: Mon, 19 Jan 2004 10:51:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is this too ugly to merge?
Message-ID: <20040119095129.GB219@elf.ucw.cz>
References: <1073609923.2003.10.camel@laptop-linux> <20040113114913.GB269@elf.ucw.cz> <1074473094.2361.104.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074473094.2361.104.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'll take the following approach: I'm pretty sure that I've tried
> suspending userspace before kernel threads before, and still ran into
> possible deadlocks. Nevertheless, I'll set that up and then bang really
> hard on it using Michael's test scripts, and let you know the results.
> If and when we see that this approach won't cut the mustard, we can come
> back to considering this approach. Sound okay?

Well, I'd say "if this approach won't cut the mustard, and we
understand *why* it does not work". If we can find a way to deadlock
plain SIGSTOP, that's good, too, because someone will likely fix
it. (And if SIGSTOP is broken, intrusive patch is okay for fixing
that).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
