Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVCNQiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVCNQiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVCNQiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:38:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19161 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261565AbVCNQiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:38:08 -0500
Date: Mon, 14 Mar 2005 17:37:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: Albert Cahalan <albert@users.sf.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com,
       7eggert@gmx.de
Subject: Re: [PATCH][RFC] Make /proc/<pid> chmod'able
Message-ID: <20050314163749.GA5186@elf.ucw.cz>
References: <1110771251.1967.84.camel@cube> <42355C78.1020307@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42355C78.1020307@lsrfire.ath.cx>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >This is a bad idea. Users should not be allowed to
> >make this decision. This is rightly a decision for
> >the admin to make.
> 
> Why do you think users should not be allowed to chmod their processes' 
> /proc directories?  Isn't it similar to being able to chmod their home 
> directories?  They own both objects, after all (both conceptually and as 
> attributed in the filesystem).

As a co-admin of university server...

Yes, I want users to see what each other user is doing. That way, if
someone hacks one account, some other user can notice and tell me.

In some environments it may make sense not to allow users to chmod
their $HOMEs (so that they can't hide mp3's etc), but we are not
*that* stupid/paranoid ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
