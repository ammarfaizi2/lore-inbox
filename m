Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVITAwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVITAwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 20:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVITAv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 20:51:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964811AbVITAv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 20:51:59 -0400
Date: Mon, 19 Sep 2005 17:51:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
       git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Cogito-0.15
In-Reply-To: <20050919231538.GA4074@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0509191750480.2553@g5.osdl.org>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
 <20050919011428.GF22391@pasky.or.cz> <20050919231538.GA4074@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Sep 2005, Pavel Machek wrote:
> 
> Could we keep at least the cg-update name? It is certainly not a
> *pull* because it does update local repository (and tree, too).

That _is_ what "pull" means.

"fetch" is the one that only updates the history. A "pull" also does a
merge and updates the current branch _and_ the currently checked out tree.

		Linus
