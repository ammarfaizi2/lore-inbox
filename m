Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270848AbTGVTiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270849AbTGVTiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:38:04 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:21518
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270848AbTGVTiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:38:02 -0400
Date: Tue, 22 Jul 2003 12:53:06 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
Message-ID: <20030722195306.GA1176@matchmail.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <bUil.2D8.11@gated-at.bofh.it> <pan.2003.07.22.15.14.44.457281@mtco.com> <20030722180442.6c116e1c.martin.zwickel@technotrend.de> <1058899302.733.1.camel@teapot.felipe-alfaro.com> <20030722193917.GA14669@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722193917.GA14669@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 09:39:17PM +0200, Jose Luis Domingo Lopez wrote:
> On Tuesday, 22 July 2003, at 20:41:42 +0200,
> Felipe Alfaro Solana wrote:
> 
> > Could you please test 2.6.0-test1-mm2? It includes some scheduler fixes
> > from Con Kolivas that will help in reducing or eliminating your
> > starvation issues.
> > 
> I was having the same jumpy mouse behaviuor with 2.6.0-test1, and on an
> otherwise idle Pentium III at 600 MHz box, scrolling a very simple HTML
> page in Mozilla makes xmms skip audio.
> 
> Then I tried 2.6.0-test1-mm2, and several things happened: now scrolling
> an HTML page in Mozilla seems not to affect MP3 playback with XMMS, but
> this is the only possitive effect. Focusing windows raises them way
> slower than in 2.6.0-test1, scheduler starvation is constant (just try
> to do something like going to another virtual desktop), and then, after
> several minutes, only XMMS got CPU time, the rest of the applications
> (at least, those running over X-Window) get stalled.

Yes, I get the same thing with KDE 3.1.  Are you using KDE or Gnome?  And if
so, what version?
