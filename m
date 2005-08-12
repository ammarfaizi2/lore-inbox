Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVHLMlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVHLMlm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 08:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVHLMlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 08:41:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57231 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751160AbVHLMll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 08:41:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200508121329.46533.phillips@istop.com> 
References: <200508121329.46533.phillips@istop.com>  <200508110812.59986.phillips@arcor.de> <20050808145430.15394c3c.akpm@osdl.org> <26569.1123752390@warthog.cambridge.redhat.com> 
To: Daniel Phillips <phillips@istop.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Fri, 12 Aug 2005 13:41:19 +0100
Message-ID: <5278.1123850479@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@istop.com> wrote:

> You also achieved some sort of new low point in the abuse of StudlyCaps
> there.  Please, let's not get started on mixed case acronyms.

My patch has been around for quite a while, and no-one else has complained,
not even you before this point. Plus, you don't seem to be complaining about
PageSwapCache... nor even PageLocked.

I'm just requesting that you base your stuff on my patch that's already in
-mm. The names in there are already in use, though not currently in the -mm
patch (the patches that use it have been temporarily dropped).

> Anyway, it sounds like you want to bless the use of private page flags in
> filesystems. That is most probably a bad idea.

Just because you don't like it doesn't make it a bad idea or wrong.

Please then suggest an alternative way of doing this. Do you understand the
problem I'm trying to solve?

> Take a browse through the existing users and feast your eyes on the
> spectacular lack of elegance.

There may be plenty of inelegance in the kernel, but this comment isn't very
helpful. I've looked at an awful lot of code and cogitated much and tried
different ways of doing things. Currently this is the best I've come up with.

David
