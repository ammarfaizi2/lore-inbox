Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318987AbSHMQsu>; Tue, 13 Aug 2002 12:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318988AbSHMQsu>; Tue, 13 Aug 2002 12:48:50 -0400
Received: from ns.suse.de ([213.95.15.193]:49928 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318987AbSHMQsn>;
	Tue, 13 Aug 2002 12:48:43 -0400
Date: Tue, 13 Aug 2002 18:52:33 +0200
From: Dave Jones <davej@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       marcelo@conectiva.com.br
Subject: Re: Trivial Patch Policy (trivial@rustcorp.com.au)
Message-ID: <20020813185233.J13598@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, marcelo@conectiva.com.br
References: <20020812020958.93C7B2C07A@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020812020958.93C7B2C07A@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Aug 12, 2002 at 05:07:05PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 05:07:05PM +1000, Rusty Russell wrote:
 > 2) The patch will not be forwarded to anyone until a new kernel has
 >    been released after I receive the patch, *unless* noone else is
 >    sent the patch.  So if you cc: the trivial patch monkey, it'll only
 >    be forwarded from there if it doesn't make the next kernel.

What happens in this case..

person a sends the monkey a patch.
person b replies to l-k (cc'ing monkey) with a "no do it this way" ?

do you have a hand-operated means to say "this patch supercedes the
previous" ?

 > 3) The first time the patch is forwarded, it will be sent to the
 >    author and/or maintainer.  If they say they've included it in their
 >    tree, no more forwards will occur (modulo some timeout eventually).
 >    If they NAK it, the patch will be closed.  Otherwise, the patch
 >    will be sent directly to Linus or Marcelo on future forwards (the
 >    maintainer will still be cc'd).

What would be *really* good, for the case where retransmits are
necessary, if Alan hasn't picked it up for 2.4 (or me for 2.5),
you could add us to the relevant Cc's, (and remove after Alan/Myself
takes it).
This could however get tricky, as the same patch may need a bit
of hand-merging to fit against -ac/-dj.

Maybe just simpler to remove us when Alan/I send an ACK ?

 > Hopefully this will be a good compromise between coordinating with
 > maintainers who want control of their files, and stopping trivial
 > patches from slipping through the cracks.

Indeed. It's been a really useful effort, and has picked up
a lot of the smaller bits which have saved me having to push those
to Linus, leaving me free to concentrate on some of the larger bits.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
