Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTESDn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 23:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTESDn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 23:43:27 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:13524 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S262323AbTESDn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 23:43:26 -0400
Date: Sun, 18 May 2003 20:51:20 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Felix von Leitner <felix-kernel@fefe.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: need better I/O scheduler for bulk file serving
In-Reply-To: <200305182338_MC3-1-397F-D9FD@compuserve.com>
Message-ID: <Pine.LNX.4.44.0305182046030.15045-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it sounds like it's just slow disk.  our redhat mirror held steady at 
about 89Mb/s during the rh9 release. using 2.4.18 384MB of ram and a 
4x120GB sw raid5 stripe with 64k block size.

joelja

On Sun, 18 May 2003, Chuck Ebbert wrote:

> Felix von Leitner wrote:
> 
> > When three people are downloading different images (my server "only" has
> > 512 MB RAM, so it can't hold even one of the images in memory) at the
> > same time, the bandwidth utilization goes down to 6 MB/sec on my fast
> > ethernet NIC.  The hard disk appears to be busy seeking.
> 
>   Try RAID1.
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


