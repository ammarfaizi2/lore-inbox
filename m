Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbTBKHcH>; Tue, 11 Feb 2003 02:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267189AbTBKHcH>; Tue, 11 Feb 2003 02:32:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32004 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265517AbTBKHcH>; Tue, 11 Feb 2003 02:32:07 -0500
Date: Mon, 10 Feb 2003 23:38:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oleg Drokin <green@namesys.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.60
In-Reply-To: <20030211100847.B5850@namesys.com>
Message-ID: <Pine.LNX.4.44.0302102336530.3543-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Feb 2003, Oleg Drokin wrote:
> 
> One of yours hand merged UML updates/fixes in, and another one broke it badly by introducing
> sigprocmask(). Now there is a conflict between in-kernel sigprocmask() and
> glibc's sigprocmask() (that UML uses to manage signal delivery to right thread).
> Can we please change the name of in-kernel's sigprocmask() to avoid name clash? ;)

No. I'm not goinmg to start caring about user-land naming in-kernel, that
way is a slippery slope. This is firmly a UML problem.

		Linus

