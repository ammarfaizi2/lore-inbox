Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbTGVTYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbTGVTYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:24:16 -0400
Received: from 217-124-16-150.dialup.nuria.telefonica-data.net ([217.124.16.150]:40333
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S267634AbTGVTYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:24:15 -0400
Date: Tue, 22 Jul 2003 21:39:17 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
Message-ID: <20030722193917.GA14669@localhost>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <bUil.2D8.11@gated-at.bofh.it> <pan.2003.07.22.15.14.44.457281@mtco.com> <20030722180442.6c116e1c.martin.zwickel@technotrend.de> <1058899302.733.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058899302.733.1.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22 July 2003, at 20:41:42 +0200,
Felipe Alfaro Solana wrote:

> Could you please test 2.6.0-test1-mm2? It includes some scheduler fixes
> from Con Kolivas that will help in reducing or eliminating your
> starvation issues.
> 
I was having the same jumpy mouse behaviuor with 2.6.0-test1, and on an
otherwise idle Pentium III at 600 MHz box, scrolling a very simple HTML
page in Mozilla makes xmms skip audio.

Then I tried 2.6.0-test1-mm2, and several things happened: now scrolling
an HTML page in Mozilla seems not to affect MP3 playback with XMMS, but
this is the only possitive effect. Focusing windows raises them way
slower than in 2.6.0-test1, scheduler starvation is constant (just try
to do something like going to another virtual desktop), and then, after
several minutes, only XMMS got CPU time, the rest of the applications
(at least, those running over X-Window) get stalled.

Hope this helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test1)
