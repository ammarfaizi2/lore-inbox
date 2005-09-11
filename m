Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVIKWHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVIKWHr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVIKWHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:07:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750966AbVIKWHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:07:46 -0400
Date: Sun, 11 Sep 2005 15:07:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCHES] kbuild fixes
In-Reply-To: <20050911214850.GA2177@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0509111505190.3242@g5.osdl.org>
References: <20050911214850.GA2177@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Sam Ravnborg wrote:
> 
> I've started suing the alternate format as you described.
> So I cannot pull from that respository myself.

Btw, it works for me, so your archive looks ok.

Your diffstat is broken, though:

>  Makefile                             |    1 
>  b/Makefile                           |   23 +-

Notice how "Makefile" shows up twice, because you didn't use "-p1" to
diffstat (or just use "git-apply --stat", which should get it right).

>  13 files changed, 345 insertions(+), 337 deletions(-)

The real stats are:

 12 files changed, 345 insertions(+), 337 deletions(-)

according to git, thanks to that.

		Linus
