Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317499AbSGJH3b>; Wed, 10 Jul 2002 03:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSGJH3a>; Wed, 10 Jul 2002 03:29:30 -0400
Received: from 205-158-62-93.outblaze.com ([205.158.62.93]:54449 "HELO
	ws3-3.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317499AbSGJH3a>; Wed, 10 Jul 2002 03:29:30 -0400
Message-ID: <20020710073209.6078.qmail@email.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: viro@math.psu.edu, acme@conectiva.com.br
Cc: rml@mvista.com, haveblue@us.ibm.com, wli@holomorphy.com,
       ricklind@us.ibm.com, greg@kroah.com,
       kernel-janitor-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Date: Wed, 10 Jul 2002 02:32:09 -0500
Subject: Re: BKL removal
X-Originating-Ip: 166.90.46.48
X-Originating-Server: ws3-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: Alexander Viro 
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: BKL removal
 
> On Tue, 9 Jul 2002, Arnaldo Carvalho de Melo wrote:
> 
> > Try smatch:
> > 
> > http://smatch.sf.net
> > 
> > And see if you can write a smatch script to get a good broom for this trash 8)
> 

I certainly am flatterred :) 

But basically what Alexander Viro said is all true.  The other problem that he didn't mention was that I don't see how checkers can be built to handle loops.  In writing smatch I just ignore loops altogether.

For now I just take the quick and dirty approach.  Also smatch really isn't finished yet.  I worked on it for a half hour tonight and fixed the bugs with the lock_kernel check.  Tomorrow I'll maybe add support for while, for, switch and break statements.

regards,
dan carpenter


-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8

