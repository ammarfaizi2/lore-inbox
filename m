Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbVHSKFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbVHSKFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 06:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVHSKFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 06:05:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53974 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932608AbVHSKFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 06:05:10 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050818222721.GC4275@elf.ucw.cz> 
References: <20050818222721.GC4275@elf.ucw.cz>  <20050816135900.GA3326@elf.ucw.cz> <200508121329.46533.phillips@istop.com> <200508110812.59986.phillips@arcor.de> <20050808145430.15394c3c.akpm@osdl.org> <26569.1123752390@warthog.cambridge.redhat.com> <5278.1123850479@warthog.cambridge.redhat.com> <7489.1124375598@warthog.cambridge.redhat.com> 
To: Pavel Machek <pavel@suse.cz>
Cc: David Howells <dhowells@redhat.com>, Daniel Phillips <phillips@istop.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Fri, 19 Aug 2005 11:04:42 +0100
Message-ID: <8880.1124445882@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:

> > I disagree again. I don't think PageFsMisc() is particularly ugly or
> > unreadable; and it makes it a touch more likely that someone reading code
> > that uses it will notice that it's a miscellaneous flag specifically for
> > filesystem use (you can't rely on them going and looking in the header
> > file for a comment).
> 
> Well, is it PageFsMisc or PageFSMisc? Subject gets second variant, and
> I like it better, too. (That does not mean I like it).

The Subject wasn't set by me. Somehow the PageFsMisc variant looks better to
me, but I could just be biased.

David
