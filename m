Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVDSW6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVDSW6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 18:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVDSW6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 18:58:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37320 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261728AbVDSW6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 18:58:34 -0400
Date: Wed, 20 Apr 2005 00:58:30 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Junio C Hamano <junkio@cox.net>
Cc: Steven Cole <elenstev@mesatop.com>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
       Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-ID: <20050419225830.GH9305@pasky.ji.cz>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <426583D5.2020308@mesatop.com> <20050419222609.GE9305@pasky.ji.cz> <7vpswqpes1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vpswqpes1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Apr 20, 2005 at 12:45:02AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> I'm wondering if doing
> 
> PB> if [ "$(show-diff)" ]; then
> PB> 	git diff | git apply
> PB> else
> PB> 	checkout-cache -f -a
> PB> fi
> 
> PB> would actually buy us some time; or, how common is it for people to have
> PB> no local changes whatsoever, and whether relative slowdown of additional
> PB> show-diff to git diff would actually matter.
> 
> "show-diff -s" perhaps.  Also wouldn't it be faster to pipe
> show-diff output (not git diff output) to patch (not git apply)?

Excellent idea, thanks. Changed git merge to do this.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
