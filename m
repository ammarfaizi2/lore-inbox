Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268359AbRGWWPU>; Mon, 23 Jul 2001 18:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268351AbRGWWPK>; Mon, 23 Jul 2001 18:15:10 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:29716
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S268350AbRGWWOw>; Mon, 23 Jul 2001 18:14:52 -0400
Date: Mon, 23 Jul 2001 15:14:57 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        linux-fsdev@vger.kernel.org, maritza@libertsurf.fr,
        rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
Message-ID: <20010723151457.C14194@work.bitmover.com>
Mail-Followup-To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
	linux-fsdev@vger.kernel.org, maritza@libertsurf.fr,
	rusty@rustcorp.com.au
In-Reply-To: <3B5C91DA.3C8073AC@wanadoo.fr> <20010723141751.W6820@work.bitmover.com> <3B5C9E95.8BF61D7A@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B5C9E95.8BF61D7A@wanadoo.fr>; from jerome.de-vivie@wanadoo.fr on Tue, Jul 24, 2001 at 12:00:53AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 12:00:53AM +0200, Jerome de Vivie wrote:
> I absolutely don't know how much work it is. Will you work again on this
> topic ?

Err, I've got a young but healthy company that is already doing it.  I'm 
happy to offer what advice I can to help you but I can't really commit
substantial resources towards this.  I make my living off of my company
and that has to come first.  That said, it's an interesting area and it's
nice to see others take an interest, so I'll help a little...

> To work on a file, we just break and copy the link. But, i don't see how
> to work with 2 versions of the same file with hard link.

You don't want to do so.  You save little by doing so.  Please tell me you
weren't going to version control at the block level, therein lies the path
to insanity.  Getting it right at the file boundary is hard enough.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
