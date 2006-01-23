Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWAWRBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWAWRBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 12:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWAWRBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 12:01:22 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:61847 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964827AbWAWRBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 12:01:20 -0500
Date: Mon, 23 Jan 2006 15:01:27 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: Adds two missing kmalloc() checks.
Message-Id: <20060123150128.eb12603f.lcapitulino@mandriva.com.br>
In-Reply-To: <1138035122.10527.10.camel@localhost>
References: <20060123133121.70f2cbcb.lcapitulino@mandriva.com.br>
	<1138034316.10527.2.camel@localhost>
	<1138034695.2977.48.camel@laptopd505.fenrus.org>
	<1138035122.10527.10.camel@localhost>
Organization: Mandriva
X-Mailer: Sylpheed version 2.2.0beta4 (GTK+ 2.8.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Pekka, Arjan,

On Mon, 23 Jan 2006 18:52:02 +0200
Pekka Enberg <penberg@cs.helsinki.fi> wrote:

| On Mon, 2006-01-23 at 18:38 +0200, Pekka Enberg wrote:
| > > Looks good to me. Arjan, you had some objections last time around. Are
| > > you okay with the change?
| 
| On Mon, 2006-01-23 at 17:44 +0100, Arjan van de Ven wrote:
| > I still fail to see the point. Has anyone EVER seen these trigger????
| 
| Yeah, we probably won't. They seem useful for people who hunt unchecked
| kmalloc() calls, though.

 It really looks useful to me. You don't check for fail because someone has
seen the fail happen. You check for fail in order to have a robust program.

 There are zilions of checks in the kernel and in programs out there which I
think they will never fail. But they are there.

 On the other hand, I'm not going to make too much noise for a such trivial
patch. If you think it's not useful, let's drop it. No problem.

-- 
Luiz Fernando N. Capitulino
