Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262451AbSJKNnq>; Fri, 11 Oct 2002 09:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbSJKNnq>; Fri, 11 Oct 2002 09:43:46 -0400
Received: from magic.adaptec.com ([208.236.45.80]:32216 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262444AbSJKNno>; Fri, 11 Oct 2002 09:43:44 -0400
Message-ID: <A3B9245C291EEF4785A24A1DBE8D852B0376B0@rtpexc01.adaptec.com>
From: "Jeffery, David" <David_Jeffery@adaptec.com>
To: "'Dave Hansen'" <haveblue@us.ibm.com>
Cc: linux-scsi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: RE: Degraded I/O performance, since 2.5.41
Date: Fri, 11 Oct 2002 09:49:23 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> From: Dave Hansen 
> James Bottomley wrote:
> > OK, this patch should fix it.  Do your performance numbers 
> for ips improve 
> > again with this?
> 
> Yes, they are better, but still about 10% below what I was seeing 
> before.  Thank you for getting this out so quickly.  I can do 
> reasonable work with this.
> 
> Are the ServeRAID people aware of this situation?  Do they know that 
> their performance could be in the toliet if they don't 
> implement queue 
> resizing in the driver?
> -- 
> Dave Hansen
> haveblue@us.ibm.com
> 

Dave,

Thank you for for adding me to the CC list.  I didn't realize how the
queueing work would affect scsi drivers.

I'm using an older 2.5 kernel so I hadn't seen the performance drop.
I'll update my kernel and get to work on it next week when I have
time.

David Jeffery
