Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbTIYRKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbTIYRKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:10:33 -0400
Received: from web40911.mail.yahoo.com ([66.218.78.208]:32834 "HELO
	web40911.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261200AbTIYRK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:10:26 -0400
Message-ID: <20030925171025.98557.qmail@web40911.mail.yahoo.com>
Date: Thu, 25 Sep 2003 10:10:25 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: 2.6.0-test broke RPM 4.2 on Red Hat 9 in a VERY weird way
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F731BE2.6020300@rackable.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Flory,

--- Samuel Flory <sflory@rackable.com> wrote:
> Bradley Chapman wrote:
> > Mr. Dovera,
> > 
> > --- Paolo Dovera <pdovera@bmind.it> wrote:
> > 
> >>Hi, try this:
> >>
> >>export LD_ASSUME_KERNEL=2.4.1
> >>
> >>before run rpm command, this works fine on my RH9
> > 
> > 
> > Hmmm. What version of glibc do you have? I have glibc 2.3.2 installed and
> > I get the same error with LD_ASSUME_KERNEL=2.4.1
> > 
> > I tried LD_ASSUME_KERNEL=2.4.22, since everything is good under 2.4, but that
> > didn't help either. Another guy said to check the archives, which I did, but
> > I don't know what to search for.
> 
> 
>    Are you doing LD_ASSUME_KERNEL=2.4.1 on the same line as the rpm command?
> 
> This should work:
> LD_ASSUME_KERNEL=2.4.1 rpm -qa
> 
> This shouldn't:
> LD_ASSUME_KERNEL=2.4.1
> rpm -qa

I tried it the first way and I got the same error. I've already upgraded my glibc;
do I need to reboot to 2.4.22-ac2 and upgrade some other system component, like
ld.so?

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
