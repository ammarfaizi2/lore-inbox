Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132054AbRDCB3u>; Mon, 2 Apr 2001 21:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132471AbRDCB3l>; Mon, 2 Apr 2001 21:29:41 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:991 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S132054AbRDCB3U>; Mon, 2 Apr 2001 21:29:20 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880A04@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: vmalloc on 2.4.x on ia64
Date: Mon, 2 Apr 2001 19:28:37 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is what I said. I am using vmalloc only. But the call to
vmalloc is hanging.

-hiren

> -----Original Message-----
> From: Matt_Domsch@Dell.com [mailto:Matt_Domsch@Dell.com]
> Sent: Monday, April 02, 2001 6:26 PM
> To: hiren_mehta@agilent.com
> Subject: RE: vmalloc on 2.4.x on ia64
> 
> 
> kmalloc() has a limit of 128KB.  Use get_free_pages() or 
> vmalloc() instead,
> or break up your allocation into smaller hunks.
> 
> Thanks,
> Matt
> 
> -- 
> Matt Domsch
> Sr. Software Engineer
> Dell Linux Systems Group
> Linux OS Development
> www.dell.com/linux
> 
> 
> 
> > -----Original Message-----
> > From: MEHTA,HIREN (A-SanJose,ex1) [mailto:hiren_mehta@agilent.com]
> > Sent: Monday, April 02, 2001 7:07 PM
> > To: 'linux-kernel@vger.kernel.org'
> > Subject: vmalloc on 2.4.x on ia64
> > 
> > 
> > Greetings.
> > 
> > Is vmalloc() interface broken on any of 2.4.x kernel on ia64 ?
> > I am trying to call vmalloc from the driver to allocate
> > about 130kb of memory and it hangs the system.
> > I am running 2.4.1 kernel with ia64 patch (I can find out the
> > exact patch if needed) on LION. Let me know if more information
> > is required.
> > 
> > Thanks and regards,
> > -hiren
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> 
