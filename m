Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265333AbUEOAfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265333AbUEOAfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUEOAbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:31:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:65256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265341AbUEOA1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:27:36 -0400
Date: Fri, 14 May 2004 17:27:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: Andy Lutomirski <luto@myrealbox.com>, Chris Wright <chrisw@osdl.org>,
       Andy Lutomirski <luto@stanford.edu>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] scaled-back caps, take 4
Message-ID: <20040514172732.F21045@build.pdx.osdl.net>
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40A4F163.6090802@stanford.edu> <20040514110752.U21045@build.pdx.osdl.net> <200405141548.05106.luto@myrealbox.com> <87hduisgda.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87hduisgda.fsf@goat.bogus.local>; from olaf+list.linux-kernel@olafdietsche.de on Sat, May 15, 2004 at 02:06:57AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Olaf Dietsche (olaf+list.linux-kernel@olafdietsche.de) wrote:
> Andy Lutomirski <luto@myrealbox.com> writes:
> 
> > cap_2.6.6-mm2_4.patch: New stripped-back capabilities.
> >
> >  fs/exec.c               |   15 ++++-
> >  include/linux/binfmts.h |    9 ++-
> >  security/commoncap.c    |  130 ++++++++++++++++++++++++++++++++++++++++++------
> >  3 files changed, 136 insertions(+), 18 deletions(-)
> [patch]
> 
> Why don't you provide this as a configurable andycap.c module?
> I think, this is the whole point of LSM.

I agree, if we can't find a clean way to do it.  However, note this
includes changes to core.  And it's nice to fix this for the base case.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
