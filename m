Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUFBQRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUFBQRu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUFBQRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:17:50 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:19089 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261628AbUFBQRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:17:47 -0400
Date: Wed, 2 Jun 2004 18:17:21 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040602161721.GA29296@wohnheim.fh-wedel.de>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl> <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org> <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <20040602142748.GA25939@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020743260.3403@ppc970.osdl.org> <20040602150440.GA26474@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020807270.3403@ppc970.osdl.org> <20040602152741.GC26474@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020839230.3403@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406020839230.3403@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 June 2004 08:52:53 -0700, Linus Torvalds wrote:
> 
> I think the above syntax is both human-readable and "obviously parseable" 
> in many trivial ways. Whaddaya think? Works for you?

Works for me for trivial recursions (just one function involved.  With
a little more pain, it should work for basically everything.  Only
exception are multiple recursions around the same function.  So unless
you like to keep those suckers, I'm fine with it.

Jörn

-- 
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories
