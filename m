Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUD1XYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUD1XYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbUD1XYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:24:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21671 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261857AbUD1XYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:24:39 -0400
Date: Wed, 28 Apr 2004 19:24:18 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Paulo Marques <pmarques@grupopie.com>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <408E5944.8090807@grupopie.com>
Message-ID: <Pine.LNX.4.44.0404281922310.19633-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Paulo Marques wrote:

> The way I see it, they know a C string ends with a '\0'. This is like saying 
> that a English sentence ends with a dot. If they wrote "GPL\0" they are 
> effectively saying that the license *is* GPL period.
> 
> So, where the source code? :)

Definitely my favorite approach of dealing with these
people.  Does anybody know whether their modules use
any EXPORT_SYMBOL_GPL symbols and whether they touch
any code I could claim copyright on ?

If it touches any of my code, where should I mail the
cease & desist ? ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

