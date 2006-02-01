Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWBAHVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWBAHVk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWBAHVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:21:40 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:21972 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751353AbWBAHVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:21:40 -0500
From: Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] PCI patches for 2.6.16-rc1
References: <20060201020437.GA20719@kroah.com>
	<Pine.LNX.4.64.0601311813400.7301@g5.osdl.org>
	<20060201040336.GA26107@suse.de>
	<Pine.LNX.4.64.0601312016370.7301@g5.osdl.org>
cc: linux-kernel@vger.kernel.org
Date: Tue, 31 Jan 2006 23:21:38 -0800
In-Reply-To: <Pine.LNX.4.64.0601312016370.7301@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 31 Jan 2006 20:19:55 -0800 (PST)")
Message-ID: <7v8xsvk0hp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, Linas - even if you can't fix your broken mail setup, what you _can_ 
> do is to always make sure that the patches you send out have
>
> 	From: Linas Vepstas <linas@austin.ibm.com>
>
> as the first line of the body - then the tools will figure out to use that 
> instead of the broken mail headers. Ok?

BTW, Linus - even if Linas did you already have commits with
broken author information; what you _can_ do is to have the
following entry in a .mailmap file in your linux-2.6.git
repository, where you run git-shortlog for your next
announcement:

        $ cat .mailmap
        Linas Vepstas <linas@austin.ibm.com>
        Linus Torvalds <torvalds@osdl.org>
        ...
        $ 

Then the tool will pick up Author: line of the commit (which
is {'linas', '<linas@austin.ibm.com>'} pair) and figure out to
use the canonical "name" you define there instead of the broken
commit headers.  OK?

> (This is true in general - so anybody else who knows that they send out 
> emails from a strange address that they'd rather have show up as their 
> "real" email address instead in the changelogs can do the same).

(This is also true in general - so any upstream maintainer who
ended up with commits that have badly formatted author
information in his repository that they'd rather have show up
nicer in the changelogs can do the same).

> 		Linus

		Junio ;-).

