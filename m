Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVBPWlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVBPWlW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 17:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVBPWlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 17:41:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:6348 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262104AbVBPWlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 17:41:21 -0500
Date: Wed, 16 Feb 2005 14:46:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: zippel@linux-m68k.org, schwab@suse.de, linux-kernel@vger.kernel.org,
       tytso@mit.edu
Subject: Re: Pty is losing bytes
Message-Id: <20050216144616.763e695b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502161156490.2383@ppc970.osdl.org>
References: <jebramy75q.fsf@sykes.suse.de>
	<Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
	<je1xbhy3ap.fsf@sykes.suse.de>
	<Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org>
	<Pine.LNX.4.61.0502160405410.15339@scrub.home>
	<Pine.LNX.4.58.0502151942530.2383@ppc970.osdl.org>
	<Pine.LNX.4.61.0502161147510.15340@scrub.home>
	<Pine.LNX.4.58.0502161156490.2383@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Wed, 16 Feb 2005, Roman Zippel wrote:
> > 
> > Below is a new patch, which also fixes problems with very long lines.
> 
> Ok, I agree with this one, but won't dare to apply it right now. Remind me 
> post-2.6.11, or - even better - see if one of the alternate trees wants to 
> fix and test this (-mm, -ac, vendors, who-ever).

I scooped it up.
