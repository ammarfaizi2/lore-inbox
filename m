Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUD2ACh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUD2ACh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUD2ACh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:02:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32953 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262079AbUD2ACg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:02:36 -0400
Date: Wed, 28 Apr 2004 20:02:21 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marc Boucher <marc@linuxant.com>
cc: Timothy Miller <miller@techsource.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <975460FA-994A-11D8-85DF-000A95BCAC26@linuxant.com>
Message-ID: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Marc Boucher wrote:

> At the same time, I think that the "community" should, without 
> relinquishing its principles, be less eager before getting the facts to 
> attack people and companies trying to help in good faith, and be more 
> realistic when it comes to satisfying practical needs of ordinary 
> users.

I wouldn't be averse to changing the text the kernel prints
when loading a module with an incompatible license. If the
text "$MOD_FOO: module license '$BLAH' taints kernel." upsets
the users, it's easy enough to change it.

How about the following?

"Due to $MOD_FOO's license ($BLAH), the Linux kernel community
cannot resolve problems you may encounter. Please contact
$MODULE_VENDOR for support issues."



-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

