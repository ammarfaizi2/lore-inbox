Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272882AbTHEWLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272893AbTHEWLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:11:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4069 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272882AbTHEWL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:11:27 -0400
Date: Tue, 5 Aug 2003 19:09:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.22-pre10] SAK: If a process is killed by SAK, give us an info about which one was killed
Message-ID: <20030805170957.GA6391@openzaurus.ucw.cz>
References: <200307312254.16964.m.c.p@wolk-project.de> <1059739764.18399.0.camel@dhcp22.swansea.linux.org.uk> <20030805105901.GA329@elf.ucw.cz> <1060101516.1188.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060101516.1188.7.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > I agree it is not good enough for 2.4.X, but it looks good to me for
> > 2.6. That information can be get by ps, right? If we decide it is not
> > okay to print process names to syslog, maybe oom killer should be
> > fixed, too?
> 
> SAK allows me to see what was running without having an account on the box

Hmm, but current situation in such case is an admin with some dead processes and no idea
what went wrong :-(
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

