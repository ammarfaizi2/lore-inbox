Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbVI3LzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVI3LzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 07:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVI3LzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 07:55:08 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31899 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751440AbVI3LzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 07:55:06 -0400
From: Junio C Hamano <junkio@cox.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: [howto] Kernel hacker's guide to git, updated
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
	<433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net>
	<433D1E5D.20303@pobox.com>
Date: Fri, 30 Sep 2005 04:55:04 -0700
In-Reply-To: <433D1E5D.20303@pobox.com> (Jeff Garzik's message of "Fri, 30 Sep
	2005 07:15:41 -0400")
Message-ID: <7v64si4von.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> ...  Once the 'git fetch --tags' changes make it into the
> official repository (are they there already?), I'll remove all
> the remaining direct references to running rsync.

Sounds like a thinly veiled threat and/or very effective
prodding ;-).

It is not there yet only because I simply have not got around to
it, but it will happen before 0.99.8.

I suspect the version Linus posted has a funny interaction with
'git-pull'; 'git pull --tags' by mistake, or intentionally to
file a bug report to annoy me ;-), would create an Octopus out
of those tags, if I am not mistaken.

> 2) What is the easiest way to obtain a list of changes present in 
> repository B, that are not present in repository A?  I used to use 
> git-changes-script [hacked cg-log script] for this:

I think I still have the copy you sent to the list.  If you do
not mind me placing in the master branch just holler -- better
yet please send a patch with commit log and signoff to add the
latest, and I will apply it.

-jc

