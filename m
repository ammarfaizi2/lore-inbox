Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWISWBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWISWBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWISWBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:01:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9155 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751160AbWISWBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:01:43 -0400
Date: Tue, 19 Sep 2006 21:56:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] security: add a mount option to make caps inheritable, re-enable CAP_SETPCAP
Message-ID: <20060919195603.GC7246@elf.ucw.cz>
References: <20060915153918.GA29528@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915153918.GA29528@clipper.ens.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Attempt to make capabilities mildly useful, without breaking anything
> and while still adhering to POSIX.1e semantics:
> 
>  * add a "inhcaps" mount option (MS_INHCAPS) which provides full
>    executable inheritable and effective sets (we cannot provide
>    finer-grained control over the mask, as fs-independent mount
>    options are only one bit wide each);

>  * re-enable CAP_SETPCAP which had been disabled following an
>    incorrect analysis of a past sendmail security hole.

Okay, I guess these two should go as a separate patches... Otherwise
patch looks okay to me.

Acked-by: Pavel Machek <pavel@suse.cz>
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
