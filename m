Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132487AbRADKU6>; Thu, 4 Jan 2001 05:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132667AbRADKUs>; Thu, 4 Jan 2001 05:20:48 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:47801 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132487AbRADKUk>; Thu, 4 Jan 2001 05:20:40 -0500
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: doug@wireboard.com (Doug McNaught), shawn.starr@home.net,
        linux-kernel@vger.kernel.org
Subject: Re: SHM Not working in 2.4.0-prerelease
In-Reply-To: <200101032021.f03KLwX394037@saturn.cs.uml.edu>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <200101032021.f03KLwX394037@saturn.cs.uml.edu>
Message-ID: <m3n1d7eix8.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 04 Jan 2001 11:16:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> >> [spstarr@coredump /etc]$ free
> >>              total       used       free     shared    buffers
> ...
> >> the shmfs is mounted. Is there any configuration i need to get
> >> shm memory activiated?
> >
> > The 'shared' field in /proc/meminfo (source for 'top' and 'free')
> > has nothing to do with {SysV,POSIX} shared memory.
> 
> Hey, that would be a good use for the field.

Not a bad idea. Then we could tell free etc to subtract this from the
+/- cached free numbers...

I will look into this.

        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
