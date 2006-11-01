Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946110AbWKAFac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946110AbWKAFac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946105AbWKAFac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:30:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11692 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946100AbWKAFab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:30:31 -0500
Date: Tue, 31 Oct 2006 21:26:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ernst Herzberg <earny@net4u.de>
cc: Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Hugh Dickins <hugh@veritas.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
In-Reply-To: <200611010611.30445.earny@net4u.de>
Message-ID: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
References: <20061029231358.GI27968@stusta.de> <20061101030126.GE27968@stusta.de>
 <200610312215.44454.len.brown@intel.com> <200611010611.30445.earny@net4u.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Nov 2006, Ernst Herzberg wrote:
> 
> still bisecting, will report the result.

Figuring out what caused an apparent change of behaviour is definitely a 
good idea - it might give us some clue to what really is going on.

(Or it might not. Sometimes the patch that triggers changes really doesn't 
seem to have anything to do with anything, and it literally was just a 
latent bug that just happened to be exposed by something that had nothing 
to do with anything at all but perhaps timing. But that's pretty rare in 
the end. It happens, but it's definitely not the common case at all, and I 
think it's great that you're bisecting even if there is a possibility 
that we'll be left with a big "Huh? Whaa?" as the end result ;^)

		Linus
