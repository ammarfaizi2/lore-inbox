Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUD1UxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUD1UxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUD1UCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:02:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52143 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261418AbUD1TRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:17:12 -0400
Date: Tue, 27 Apr 2004 20:58:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040427185800.GS2595@openzaurus.ucw.cz>
References: <408DC0E0.7090500@gmx.net> <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org> <1083045844.2150.105.camel@bach> <20040427092159.GC29503@lug-owl.de> <408E37D9.7030804@gmx.net> <408E5944.8090807@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408E5944.8090807@grupopie.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The way I see it, they know a C string ends with a '\0'. This is like 
> saying that a English sentence ends with a dot. If they wrote "GPL\0" 
> they are effectively saying that the license *is* GPL period.

If you use modinfo, license probably will be displayed as GPL.
I'd guess that sending bunch of lawyers their way is right solution.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

