Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbWKSSZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWKSSZx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 13:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWKSSZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 13:25:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:62644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932762AbWKSSZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 13:25:52 -0500
Date: Sun, 19 Nov 2006 10:25:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mike Galbraith <efault@gmx.de>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] PM: suspend/resume debugging should depend on 
 SOFTWARE_SUSPEND
In-Reply-To: <1163958727.5977.15.camel@Homer.simpson.net>
Message-ID: <Pine.LNX.4.64.0611191023390.3692@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> 
 <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <1163958727.5977.15.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2006, Mike Galbraith wrote:
> 
> Here I am wishing I had the _opportunity_ to be sane.  With my ATI X850
> AGP card, I have no choices except swsusp or reboot.

Try using regular VGA console, and letting X re-initialize the card. It's 
worked for me on several machines (Mac Mini and Compaq EVO) where the 
kernel cannot initialize the graphics itself.

It does mean that you have to run X when suspending, but most people do 
anyway..

				Linus
