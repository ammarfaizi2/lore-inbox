Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbUL3El7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUL3El7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 23:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUL3El7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 23:41:59 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:28589 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261524AbUL3El4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 23:41:56 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-ac1
Date: Wed, 29 Dec 2004 23:41:54 -0500
User-Agent: KMail/1.7
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1104103881.16545.2.camel@localhost.localdomain>
In-Reply-To: <1104103881.16545.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412292341.54834.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.52.185] at Wed, 29 Dec 2004 22:41:55 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 December 2004 18:31, Alan Cox wrote:
>Linux 2.6.10-ac1 is a merge of the stuff that has not yet been
> accepted upstream along with a couple of small extra changes that
> are needed because of changes in 2.6.10 base. In addition the
> generic IRQ work in 2.6.10 means that the forward port of the
> irqpoll code now covers a lot more platforms.

Alan: Just a quick note to say that it appears my samba problem with 
2.6.10 has been fixed by 2.6.10-ac1, I can now mount and unmount 
samba shares very quickly, as in milliseconds.

[root@coyote root]# time service asmb restart
Stopping share gene:
Stopping share dlds:
Starting share gene:
Starting share dlds:

real    0m0.276s
user    0m0.062s
sys     0m0.024s

Thats at least a second faster than its ever been before here.  Now to 
see if amanda likes it, something thats an amandad killer got in 
someplace in the mm series leading up to V0.33-04, and amandad would 
turn into a zombie, spoiling a backup.  I'll know in about 5 hours 
how that worked.  Repeated runs of amcheck seem to be fine.

[...]

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
