Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUDVTuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUDVTuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUDVTuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:50:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2511 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264639AbUDVTuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:50:11 -0400
Date: Mon, 19 Apr 2004 16:39:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: "H. J. Lu" <hjl@lucon.org>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to make stack executable on demand?
Message-ID: <20040419143957.GA831@openzaurus.ucw.cz>
References: <20040416170915.GA20260@lucon.org> <408020E2.9060900@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408020E2.9060900@domdv.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >is set with executable stack. Is there a third option that a process
> >starts with non-executable stack and can change the stack permission
> >later?
> >
> 
> Well, in my opinion your request is equivalent to "keep all these 
> cute buffer overflows forever". Take any protected app, LD_PRELOAD or 
> drop in a bad/malicious library and your're done for good. Not really 
> a good idea.

With malicious libraries, you have *way* bigger problems than
buffer overruns.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

