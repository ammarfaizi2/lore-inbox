Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbVHPN7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbVHPN7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbVHPN7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:59:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21967 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965247AbVHPN7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:59:05 -0400
Date: Tue, 16 Aug 2005 15:59:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Howells <dhowells@redhat.com>
Cc: Daniel Phillips <phillips@istop.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS
Message-ID: <20050816135900.GA3326@elf.ucw.cz>
References: <200508121329.46533.phillips@istop.com> <200508110812.59986.phillips@arcor.de> <20050808145430.15394c3c.akpm@osdl.org> <26569.1123752390@warthog.cambridge.redhat.com> <5278.1123850479@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5278.1123850479@warthog.cambridge.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You also achieved some sort of new low point in the abuse of StudlyCaps
> > there.  Please, let's not get started on mixed case acronyms.
> 
> My patch has been around for quite a while, and no-one else has complained,
> not even you before this point. Plus, you don't seem to be complaining about
> PageSwapCache... nor even PageLocked.

PageFsMisc really *is* ugly and hard to read. PageLocked etc. look
bad, too but ThIs iS rEaLlY WrOnG.

PageMisc would look less ugly, make note in a comment that it is for
filesystems only.

									Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
