Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932825AbWKST4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbWKST4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933121AbWKST43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:56:29 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932825AbWKST43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:56:29 -0500
Date: Sun, 19 Nov 2006 11:55:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mike Galbraith <efault@gmx.de>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] PM: suspend/resume debugging should depend on 
 SOFTWARE_SUSPEND
In-Reply-To: <1163962957.5868.3.camel@Homer.simpson.net>
Message-ID: <Pine.LNX.4.64.0611191155090.3692@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> 
 <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>  <1163958727.5977.15.camel@Homer.simpson.net>
  <Pine.LNX.4.64.0611191023390.3692@woody.osdl.org> <1163962957.5868.3.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2006, Mike Galbraith wrote:
>
> Thanks for the tip, but it didn't work.  It suspended instantly, and got
> my hopes up (manually, SuSE says "not supported, go away"), but resume
> still left me with an utterly dead box (minus flashing crud on display).

Right. That's why we have PM_DEBUG and PM_TRACE, and why I sent out the 
small email about how to use them.

The utterly dead box is the common case when some driver doesn't actually 
resume properly ;(

		Linus
