Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbTGEVGk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbTGEVGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:06:34 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:8387 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S266495AbTGEVGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:06:31 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Diego Calleja =?iso-8859-1?q?Garc=EDa?= <diegocg@teleline.es>
Subject: Re: 2.5.74-mm1
Date: Sat, 5 Jul 2003 23:22:10 +0200
User-Agent: KMail/1.5.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20030703023714.55d13934.akpm@osdl.org> <200307051728.12891.phillips@arcor.de> <20030705214006.37a52d15.diegocg@teleline.es>
In-Reply-To: <20030705214006.37a52d15.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200307052322.10123.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 July 2003 21:40, Diego Calleja García wrote:
> > to get us so far with this.  The situation re scheduling in 2.5 feels
> > much as the vm situation did in 2.3, in other words, we're halfway down a
> > long twisty road that ends with something that works, after having tried
> > and failed at many flavors of tweaking and tuning.  Ultimately the
> > problem will be solved by redesign, and probably not just limited to
> > kernel code.
>
> I never run 2.3, but 2.5 behaviour has been much better in the past. I used
> to run make -j25 and mp3 didn't skip, X and all apps were still very
> reponsive.
>
> That was a lot of releases ago, before the so called linus' "interactivity"
> patch. IMHO the behaviour in those releases was great; i think the
> scheduler just needs a bit of tweaking from the Ingo's hand :)

It is good, so long as the sound process runs at a higher-than-default 
priority.  Trying to get sound to run skiplessly at the same priority as a 
normal process is just a waste of time.  If it happens to work in some kernel 
versions or hardware configurations, it's an accident.

Though I've admittedly only done a small of testing, I haven't seen a glitch 
recently.  I'm a happy camper.  (Right now I'm running make -j25, apt-get 
installing OpenOffice and listening to Bolero.)

Regards,

Daniel

