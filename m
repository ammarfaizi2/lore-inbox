Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264892AbSLLRuR>; Thu, 12 Dec 2002 12:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbSLLRuR>; Thu, 12 Dec 2002 12:50:17 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:25867 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S264892AbSLLRuQ>; Thu, 12 Dec 2002 12:50:16 -0500
Date: Thu, 12 Dec 2002 17:58:04 +0000
From: John Levon <levon@movementarian.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: vamsi@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Notifier for significant events on i386
Message-ID: <20021212175804.GA15860@compsoc.man.ac.uk>
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net> <20021211165153.A17546@in.ibm.com> <20021211111639.GJ9882@holomorphy.com> <20021211171337.A17600@in.ibm.com> <20021211202727.GF20735@compsoc.man.ac.uk> <1039641336.18587.30.camel@irongate.swansea.linux.org.uk> <1039652384.1649.17.camel@dell_ss3.pdx.osdl.net> <20021212130406.A20253@in.ibm.com> <1039715615.1649.80.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039715615.1649.80.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18MXb2-000PqZ-00*8XACQrYKvhk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 09:53:35AM -0800, Stephen Hemminger wrote:

> The use of notifier today is limited to things that can't sleep. As far

kernel/profile.c

You'd have to move that to a different API if you want to force notifier
callbacks non-sleepable

regards
john

-- 
"Anyone who says you can have a lot of widely dispersed people hack away on
 a complicated piece of code and avoid total anarchy has never managed a 
 software project."
	- Andy Tanenbaum
