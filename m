Return-Path: <linux-kernel-owner+w=401wt.eu-S1030403AbWLTWZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWLTWZZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWLTWZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:25:24 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41454 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030401AbWLTWZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:25:23 -0500
From: Junio C Hamano <junkio@cox.net>
To: merlyn@stonehenge.com (Randal L. Schwartz)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] daemon.c blows up on OSX
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
Date: Wed, 20 Dec 2006 14:25:21 -0800
In-Reply-To: <86irg6yzt1.fsf_-_@blue.stonehenge.com> (Randal L. Schwartz's
	message of "20 Dec 2006 14:20:42 -0800")
Message-ID: <7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Nope... can't compile:
> ...
>     daemon.c:970: warning: implicit declaration of function 'initgroups'
>     make: *** [daemon.o] Error 1
>
> This smells like we've seen this before.  Regression introduced with
> some of the cleanup?

Most likely.  You were CC'ed on these messages:

	<7v7iwnnzed.fsf@assigned-by-dhcp.cox.net>
	<7vbqlye2zz.fsf@assigned-by-dhcp.cox.net>


