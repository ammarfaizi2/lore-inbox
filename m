Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbTCGGfI>; Fri, 7 Mar 2003 01:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbTCGGfH>; Fri, 7 Mar 2003 01:35:07 -0500
Received: from 205-158-62-95.outblaze.com ([205.158.62.95]:60353 "HELO
	ws3-5.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261381AbTCGGfG>; Fri, 7 Mar 2003 01:35:06 -0500
Message-ID: <20030307064535.20769.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: green@namesys.com
Cc: linux-kernel@vger.kernel.org, smatch-discuss@lists.sf.net
Date: Fri, 07 Mar 2003 01:45:35 -0500
Subject: Re: smatch update / 2.5.64 / kbugs.org
X-Originating-Ip: 66.127.101.73
X-Originating-Server: ws3-5.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Drokin <green@namesys.com>
> > The smatch bugs for kernel 2.5.64 are up.  The 
> > new url for the smatch bug database is http://kbugs.org.  
> 
> Unfortunatelly the bug database does not work. I mean I cannot connect to it.
> 

Crap...  sorry about that, I screwed up.

> This script can produce a lot less false positives with even more custom merge rules.
> Here's the diff that if run on fs/ext3/super.c from current bk tree, produces
> only one true bug. (your version from cvs produces one real bug and two false positives)
> (8 less hits on my default build).

I have uploaded your modifications to CVS.  I'll use it 
on the next kernel release.  The unfree.pl was just a few
modifications to the deference_check.pl so your patch
will cut down on the false positives with that also.

thanks,
dan carpenter


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Meet Singles
http://corp.mail.com/lavalife

