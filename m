Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTLLWPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTLLWPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:15:31 -0500
Received: from gprs149-168.eurotel.cz ([160.218.149.168]:898 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262104AbTLLWP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:15:27 -0500
Date: Fri, 12 Dec 2003 23:16:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@hpl.hp.com>, jbarnes@sgi.com,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] quite down SMP boot messages
Message-ID: <20031212221609.GC314@elf.ucw.cz>
References: <yq0fzfr32ib.fsf@wildopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0fzfr32ib.fsf@wildopensource.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'd like to propose this patch for 2.6.0 or 2.6.1 to quite down some
> of the excessive boot messages printed for each CPU. The patch simply
> introduces a boot time variable 'smpverbose' which users can set if
> they experience problems and want to see the full set of messages.
> 
> Once you hit > 2 CPUs the amount of noise printed per CPU starts
> becoming a pain, at 64 CPUs it's turning into a royal pain ....

You might want to be more creative.. With something like < for each
cpu going up and > for each cpu booted, you might be able to preserve
all the info yet make it _way_ shorter.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
