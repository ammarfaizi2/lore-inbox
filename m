Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUHRULY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUHRULY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUHRULY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:11:24 -0400
Received: from web11413.mail.yahoo.com ([216.136.131.59]:53122 "HELO
	web11413.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266128AbUHRULB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:11:01 -0400
Message-ID: <20040818201100.54131.qmail@web11413.mail.yahoo.com>
Date: Wed, 18 Aug 2004 13:11:00 -0700 (PDT)
From: Shriram R <shriram1976@yahoo.com>
Subject: Re: Effect of deleting executables of running programs
To: linux-kernel@vger.kernel.org
In-Reply-To: <200408181901.i7IJ1FK08538@orbit-fe.eng.netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the nodes were accessing the executable over NFS.

-shriram


--- Brian Pawlowski <beepy@netapp.com> wrote:

> How were the nodes accessing the executable? Over
> NFS?
> 
> > Hi,
> > 
> > Newbie here. I am not sure if I am sending this
> email
> > to the right list.  My apologies if I am not and I
> > would be happy if someone can point me to the
> right
> > mailing list.
> > 
> > We have a 24 node/48 processor cluster in our lab
> with
> > the following specs.
> > 
> > AMD Athlon
> > Redhat 7.3
> > Kernel version - 2.4.19
> > 
> > I had around 10 jobs that had been running on the
> > cluster for about 15 or so days.  These were
> > using a common executable "abcd.out" (compiled in
> > fortran 90).  After they had been running for
> > about 15 days, I made the mistake of deleting
> > abcd.out.  Immediately about
> > 3 or 4 of my jobs crashed with a "bus error". 
> But,
> > some 6-7 of my jobs
> > continued running.  I had 2 questions with regards
> to
> > this :
> >  
> > a) I always thought that once a job is running,
> the
> > executable is
> >    entirely loaded into memory and the abcd.out
> file
> > is no longer needed.
> >    If so, then why does the a running job crash on
> > deleting abcd.out ?  
> >  
> > b) To what extent can I trust that the rest of the
> 6-7
> > jobs that are
> >    running have not been affected by this deletion
> of
> > "abcd.out" ?
> >  
> > Thanks in advance,
> > shriram.
> > 
> > 
> > 	
> > 		
> > __________________________________
> > Do you Yahoo!?
> > New and Improved Yahoo! Mail - 100MB free storage!
> > http://promotions.yahoo.com/new_mail 
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
