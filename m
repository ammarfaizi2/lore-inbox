Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312059AbSCQPzF>; Sun, 17 Mar 2002 10:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312060AbSCQPyz>; Sun, 17 Mar 2002 10:54:55 -0500
Received: from bitmover.com ([192.132.92.2]:24969 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S312059AbSCQPyo>;
	Sun, 17 Mar 2002 10:54:44 -0500
Date: Sun, 17 Mar 2002 07:54:43 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Larry McVoy <lm@bitmover.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
Message-ID: <20020317075443.A15420@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Larry McVoy <lm@bitmover.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C938027.4040805@mandrakesoft.com> <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com> <3C938027.4040805@mandrakesoft.com> <30393.1016362174@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <30393.1016362174@redhat.com>; from dwmw2@infradead.org on Sun, Mar 17, 2002 at 10:49:34AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 10:49:34AM +0000, David Woodhouse wrote:
> But then BK wouldn't even let me pull from Linus' tree any more, because I 
> had locked and modified files. That also seems to be a fundamental flaw.

BK works that way on purpose.  If we merge changes into your local changes,
there is no automatic way to "unmerge".  It is way to easy to do a pull,
do the merge, and then realize you lost work in the merge because you told
it to do the wrong thing.

Short summary: commit your changes before you pull and you'll be fine.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
