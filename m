Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVBPT72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVBPT72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVBPT71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:59:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:64924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261861AbVBPT7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:59:15 -0500
Date: Wed, 16 Feb 2005 11:58:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Pty is losing bytes
In-Reply-To: <Pine.LNX.4.61.0502161147510.15340@scrub.home>
Message-ID: <Pine.LNX.4.58.0502161156490.2383@ppc970.osdl.org>
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
 <je1xbhy3ap.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org>
 <Pine.LNX.4.61.0502160405410.15339@scrub.home> <Pine.LNX.4.58.0502151942530.2383@ppc970.osdl.org>
 <Pine.LNX.4.61.0502161147510.15340@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Feb 2005, Roman Zippel wrote:
> 
> Below is a new patch, which also fixes problems with very long lines.

Ok, I agree with this one, but won't dare to apply it right now. Remind me 
post-2.6.11, or - even better - see if one of the alternate trees wants to 
fix and test this (-mm, -ac, vendors, who-ever).

And testing the dang thing sounds wonderful.

Andreas' testprogram is a good place to start, probably coupled with some
test-files with really really long lines or something..

		Linus
