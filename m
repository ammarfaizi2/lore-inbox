Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTEPNyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 09:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTEPNyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 09:54:51 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:26790 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S264450AbTEPNyt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 09:54:49 -0400
Message-ID: <20030516140835.21004.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com
Date: Fri, 16 May 2003 22:08:35 +0800
Subject: Re: [BENCHMARK AIM9] Regressions in 2.5.69
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@digeo.com>
Date: Fri, 16 May 2003 00:47:07 -0700
To: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
Subject: Re: [BENCHMARK AIM9] Regressions in 2.5.69

> "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org> wrote:
> >
> > Hi all/Andrew/Martin,
> >  I noticed regression in a few tests,
> >  I deleted the results of tests that don't show differences between the two kernel version.
> > 
> >  Hope it helps.
> > 
> >  Ciao,
> >  		Paolo
> >  		
> >  2.5.67
> >  2.5.69
> > 
> >  creat-clo 10010 86.8132        86813.19 File Creations and Closes/second
> >  creat-clo 10030 22.0339        22033.90 File Creations and Closes/second
> >  ^^^^BIG REGRESSION
> 
> I cannot repeat any of this.  In fact 2.5.69-mm is a bit faster than
> 2.5.67.
> 
> I tested ext2 mainly.  But a spot-check of creat-clo on reiserfs showed
> no regression either.

Ok, thanks Andrew.
I dunno what happened during the test.
I'll try again to run the test with both the kernel.
I'll back to you if I'm able to reproduce those numbers.

Ciao,
          Paolo
 

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
