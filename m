Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272745AbRILKoJ>; Wed, 12 Sep 2001 06:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272744AbRILKn7>; Wed, 12 Sep 2001 06:43:59 -0400
Received: from freerunner-o.cendio.se ([193.180.23.130]:55797 "EHLO
	mail.cendio.se") by vger.kernel.org with ESMTP id <S272737AbRILKnl>;
	Wed, 12 Sep 2001 06:43:41 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: nfs is stupid ("getfh failed")
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman>
	<15261.47176.73283.841982@notabene.cse.unsw.edu.au>
From: Marcus Sundberg <marcus@cendio.se>
Date: 12 Sep 2001 12:44:01 +0200
In-Reply-To: <15261.47176.73283.841982@notabene.cse.unsw.edu.au>
Message-ID: <vebskgpu32.fsf@inigo.sthlm.cendio.se>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

neilb@cse.unsw.edu.au (Neil Brown) writes:

> On  September 10, marcus@cendio.se wrote:
> > cachefs sucks. It doesn't seem to cache stat(2) information.
> > Doing ls -F in a ~100-entries directory takes several seconds over
> > a link with 50ms round-trip time.
> 
> Well, I said "concept" not "implementation", but I suspect that
> Solaris cachefs does cache stat information.  Maybe you just need to
> increase the timeouts for the attribute cache.

Considering that I did several ls'es on the order of milliseconds
apart I doubt that would help...

//Marcus
-- 
---------------------------------+---------------------------------
         Marcus Sundberg         |      Phone: +46 707 452062
   Embedded Systems Consultant   |     Email: marcus@cendio.se
        Cendio Systems AB        |      http://www.cendio.com
