Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTIYUSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 16:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTIYUSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 16:18:17 -0400
Received: from web40902.mail.yahoo.com ([66.218.78.199]:60198 "HELO
	web40902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261872AbTIYUSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 16:18:15 -0400
Message-ID: <20030925201814.5680.qmail@web40902.mail.yahoo.com>
Date: Thu, 25 Sep 2003 13:18:14 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: 2.6.0-test broke RPM 4.2 on Red Hat 9 in a VERY weird way
To: David T Hollis <dhollis@davehollis.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F734762.4020600@davehollis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Hollis,

--- David T Hollis <dhollis@davehollis.com> wrote:
> Bradley Chapman wrote:
> 
> >
> >I tried it the first way and I got the same error. I've already upgraded my
> glibc;
> >do I need to reboot to 2.4.22-ac2 and upgrade some other system component, like
> >ld.so?
> >
> >Brad
> >
> >
> >=====
> >Brad Chapman
> >
> >
> >  
> >
> A few ways to solve this:
> What I did before upgrading RPM was:
> export LD_ASSUME_KERNEL=2.2.5
> rpm -Uvh blah.rpm
> 
> If you upgrade to rpm that is in RedHat Rawhide (current 4.2.1-0.30), 
> this problem goes away.  You may need to upgrade your glibc as well, I'm 
> currently at 2.3.2-91 from Rawhide.
> 

Thanks! Using 2.2.5 works!

Thanks to everyone who helped out. Perhaps this needs to go into an FAQ somewhere?

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
