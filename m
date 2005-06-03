Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVFCS7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVFCS7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVFCS7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:59:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29397 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261502AbVFCS7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:59:25 -0400
Date: Fri, 3 Jun 2005 20:56:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brian Gerst <bgerst@didntduck.org>
Cc: davej@codemonkey.org.uk, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix warning in powernow-k8.c
Message-ID: <20050603185623.GJ3867@elf.ucw.cz>
References: <429F3A9E.504@didntduck.org> <20050603161132.GB5083@elf.ucw.cz> <42A0A214.6070307@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42A0A214.6070307@didntduck.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 03-06-05 14:31:48, Brian Gerst wrote:
> Pavel Machek wrote:
> >Hi!
> >
> >
> >>Fix this warning:
> >>powernow-k8.c: In function ?query_current_values_with_pending_wait?:
> >>powernow-k8.c:110: warning: ?hi? may be used uninitialized in this
> >>function
> >
> >
> >Are you sure?
> >
> >Original code is clearly buggy; I do not think you need that ugly do
> >{} while loop.
> 
> I'm not sure why you think the loop is ugly.  It makes it more obvious 
> (to us humans and the compiler) that the loop is executed at least
> one time.

Oops, sorry, I misread the patch.
								Pavel
