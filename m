Return-Path: <linux-kernel-owner+w=401wt.eu-S932713AbWLSJ24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbWLSJ24 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWLSJ24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:28:56 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:43604 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932713AbWLSJ2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:28:54 -0500
Date: Tue, 19 Dec 2006 10:28:44 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061219092844.GA23853@deprecation.cyrius.com>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org> <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org> <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org> <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org> <45861E68.3060403@yahoo.com.au> <20061217214308.62b9021a.akpm@osdl.org> <20061219085149.GA20442@torres.l21.ma.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219085149.GA20442@torres.l21.ma.zugschlus.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marc Haber <mh+linux-kernel@zugschlus.de> [2006-12-19 09:51]:
> I do not have a clue about memory management at all, but is it
> possible that you're testing on a box with too much memory? My box has
> only 256 MB, and I used to use mutt with a _huge_ inbox with mutt
> taking somewhat 150 MB. Add spamassassin and a reasonably busy mail
> server, and the box used to be like 150 MB in swap.

FWIW, the ARM box I see this on has only 32 MB memory (and a 133 or
266 MHz CPU).  I don't see it on another ARM box (different ARM
sub-arch) with 128 MB memory and a 600 MHz CPU.
-- 
Martin Michlmayr
http://www.cyrius.com/
