Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266740AbUGLHbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266740AbUGLHbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 03:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266746AbUGLHbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 03:31:11 -0400
Received: from [193.178.151.93] ([193.178.151.93]:5594 "EHLO as.unibanka.lv")
	by vger.kernel.org with ESMTP id S266740AbUGLHbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 03:31:06 -0400
From: Aivils <aivils@unibanka.lv>
Reply-To: aivils@unibanka.lv
Organization: Unibanka
To: Ingo Molnar <mingo@elte.hu>
Subject: Voluntary Preemption + concurent games
Date: Mon, 12 Jul 2004 11:23:11 +0300
User-Agent: KMail/1.6.1
References: <20040709182638.GA11310@elte.hu> <20040711143853.GA6555@elte.hu> <20040711201753.GA11073@elte.hu>
In-Reply-To: <20040711201753.GA11073@elte.hu>
Cc: ck kernel mailing list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407121123.11520.aivils@unibanka.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

	I still use in my home minicomputer under Linux, where
3 users use one CPU/RAM , but own video.
	By default 2.6.XX task scheduler don' t like concurent applications
at all. 2.6.XX task scheduler allways raise on top of tasks only one
task and keep it on top until user stop it.
	This rule is very unwanted for minicomputers, because multile
local users will use one CPU and feel lucky.

	As point of reference i use 2.4.XX tack scheduler, which is very
"righteous" and allways give CPU time for all tasks. Under 2.4.XX
concurent games run smooth.

	2.6.XX non-preemptive and 2.6.XX voluntary-preemptive task
scheduling looks very similar. My gamer' s eye report me very
thiny and very subjective difference - preferable is voluntary-preemtive.
Anyway all concurent CPU intensive tasks should be started with
nice -n +19 game-bin . Any other nice value remake one of
running game to slide show or both running games became slide show.

	So we should start any game with nice +19. In is this set goes in
netscape and konqueror because of java web-chat and games.

	At least voluntary-preemptive allow me move away from 2.4.26

Aivils Stoss
