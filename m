Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWHFSkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWHFSkj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 14:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWHFSkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 14:40:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750776AbWHFSki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 14:40:38 -0400
Date: Sun, 6 Aug 2006 11:40:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: tytso@mit.edu, multinymous@gmail.com, rlove@rlove.org, khali@linux-fr.org,
       gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded
 controller access
Message-Id: <20060806114004.ff472cff.akpm@osdl.org>
In-Reply-To: <20060806164013.GA7637@aepfle.de>
References: <11548492171301-git-send-email-multinymous@gmail.com>
	<11548492242899-git-send-email-multinymous@gmail.com>
	<20060806005613.01c5a56a.akpm@osdl.org>
	<41840b750608060256g1a7bb9c3s843d3ac08e512d63@mail.gmail.com>
	<20060806030749.ab49c887.akpm@osdl.org>
	<41840b750608060344p59293ce0xc75edfbd791b23c@mail.gmail.com>
	<20060806145551.GC30009@thunk.org>
	<20060806164013.GA7637@aepfle.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2006 18:40:13 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> On Sun, Aug 06, 2006 at 10:55:51AM -0400, Theodore Tso wrote:
> > On Sun, Aug 06, 2006 at 01:44:02PM +0300, Shem Multinymous wrote:
> 
> > > Can you please be more specific? What purpose does this exclusion
> > > serve, that would be realistically achieved otherwise? You already
> > > have a GPL license from the author, and a way to contact and uniquely
> > > identify the author.
> > 
> > For legal reasons, we need a way to to contact and identify the author
> > in the real world, not just in cyberspace, and a pseudonym doesn't
> > meet that requirement.
> 
> In that context, even an anonymous mailer like gmail and the like is
> questionable. But, I'm sure one get a domain with faked address data
> in the whois database.
> Where would you draw the line?

I have a personal line, and that is when the patch is "substantial".  (This
line is only relevant when someone forgot to add the Signed-off-by: and I'm
wondering whether to ask them to send one).

And I'd say this patch series _is_ substantial because it pokes at
registers which might be described in confidential/NDA'ed documentation, or
in ways which might be derived from $OTHER_OS.
