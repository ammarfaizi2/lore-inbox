Return-Path: <linux-kernel-owner+w=401wt.eu-S1750968AbWLMVIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWLMVIM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWLMVIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:08:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41981 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbWLMVIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:08:10 -0500
Date: Wed, 13 Dec 2006 13:08:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612131306460.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <20061213203113.GA9026@suse.de> <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2006, Linus Torvalds wrote:
> 
> Btw: there's one driver we _know_ we want to support in user space, and 
> that's the X kind of direct-rendering thing. So if you can show that this 
> driver infrastructure actually makes sense as a replacement for the DRI 
> layer, then _that_ would be a hell of a convincing argument.

Btw, the other side of this argument is that if a user-space driver 
infrastructure can _not_ help the DRI kind of situation, then it's largely 
by definition not interesting. Merging something like that would just mean 
that we end up with multiple _different_ user-space helper infrastructure 
shells, which sounds distinctly unpalatable.

		Linus
