Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316052AbSEJQHG>; Fri, 10 May 2002 12:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316054AbSEJQHF>; Fri, 10 May 2002 12:07:05 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:44025 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S316052AbSEJQHB>; Fri, 10 May 2002 12:07:01 -0400
Date: Fri, 10 May 2002 09:09:03 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Nicholas Harring <nharring@hostway.net>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Pedro M. Rodrigues" <pmanuel@myrealbox.com>, <chen_xiangping@emc.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Tcp/ip offload card driver
In-Reply-To: <3CDBEC6A.9020600@hostway.net>
Message-ID: <Pine.LNX.4.44.0205100906060.4615-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One would expect that hyper-transport would make using the cpu more 
attractive rather than less since it eleminates many of the shared 
resources that are currently bottlenecks in smp machines.

joelja

 On Fri, 10 May 
2002, Nicholas Harring wrote:

> And how about when an SMP system isn't enough? Should I have to 
> re-engineer my network storage architecture when hardware exists that'll 
> increase throughput if a simple device driver gets written? Don't forget 
> that with 64 bit PCI that the limit of the bus has been raised, and with 
> impending technologies like Infiniband and Hypertransport that limit 
> will be raised again. At that point devoting main processor resources to 
> something better handled by specialty hardware really stops making 
> sense, if that specialty hardware is low-cost (oughta be) and effective 
> (still debatable).
> 
> Nicholas Harring
> Hostway Corporation
> 
> 
> Jeff Garzik wrote:
> > Pedro M. Rodrigues wrote:
> > 
> >>   Actually there is. Think iSCSI. Have a look at this article at 
> >> LinuxJournal - http://linuxjournal.com/article.php?sid=4896 .
> >>
> > 
> > Ug...  why bother?  Just buy an SMP system at that point...
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


