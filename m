Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272863AbTG3Mb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272865AbTG3MaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:30:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53778 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272863AbTG3MaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:30:05 -0400
Date: Wed, 30 Jul 2003 14:21:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Valdis.Kletnieks@vt.edu
Cc: jimis@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related) -- conclusion
Message-ID: <20030730122115.GH2601@openzaurus.ucw.cz>
References: <3F26CAF2.8070009@gmx.net> <200307291958.h6TJw43o030219@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307291958.h6TJw43o030219@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > great, I had no idea of this potential. But what I propose is scheduling the
> > network traffic (at least the outgoing traffic that we can influence directly)
> > according to the process priority, not according to the traffic type (which is
> > important but different).
> 
> So you want to use a number that controls the CPU scheduling to force the network
> scheduling to go along?  That's a bad idea waiting to happen.
> 

Hint: he's right.

By default it is reasonable to give lower disk priority to nice -19 tasks. In some cases that
breaks, so cpu_nice, disk_nice etc. would be better.
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

