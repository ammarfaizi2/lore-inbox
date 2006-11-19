Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932873AbWKSTA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932873AbWKSTA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932934AbWKSTA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:00:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:46783 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932873AbWKSTAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:00:55 -0500
X-Authenticated: #14349625
Subject: Re: [patch] PM: suspend/resume debugging should depend on 
	SOFTWARE_SUSPEND
From: Mike Galbraith <efault@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <Pine.LNX.4.64.0611191023390.3692@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	 <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
	 <1163958727.5977.15.camel@Homer.simpson.net>
	 <Pine.LNX.4.64.0611191023390.3692@woody.osdl.org>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 20:02:37 +0100
Message-Id: <1163962957.5868.3.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 10:25 -0800, Linus Torvalds wrote:
> 
> On Sun, 19 Nov 2006, Mike Galbraith wrote:
> > 
> > Here I am wishing I had the _opportunity_ to be sane.  With my ATI X850
> > AGP card, I have no choices except swsusp or reboot.
> 
> Try using regular VGA console, and letting X re-initialize the card. It's 
> worked for me on several machines (Mac Mini and Compaq EVO) where the 
> kernel cannot initialize the graphics itself.
> 
> It does mean that you have to run X when suspending, but most people do 
> anyway..

Thanks for the tip, but it didn't work.  It suspended instantly, and got
my hopes up (manually, SuSE says "not supported, go away"), but resume
still left me with an utterly dead box (minus flashing crud on display).

	-Mike

