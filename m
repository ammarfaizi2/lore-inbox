Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVC0Wlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVC0Wlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVC0Wlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:41:45 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:1902 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261611AbVC0Wln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:41:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RzJ43FAlArF1ZoUhZGUc0gNnxPVq0Y29+Pve/gxn73m28ouZgoTp1peTY+D86EgIEoIiaaKZSSO92lXSS9HBPDsOhvzjGWjFK8zvgXs3DLRQVvyxW5A+5kBRPDKYhMEG7IAiEIQOBgvqrcXXhG22OID0R2kvMeSqYLkRnhlFlJ8=
Message-ID: <21d7e99705032714417148217f@mail.gmail.com>
Date: Mon, 28 Mar 2005 08:41:43 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Cc: Greg KH <greg@kroah.com>, Lee Revell <rlrevell@joe-job.com>,
       Mark Fortescue <mark@mtfhpc.demon.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1111948631.27594.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk>
	 <20050326182828.GA8540@kroah.com> <1111869274.32641.0.camel@mindpipe>
	 <20050327004801.GA610@kroah.com> <1111885480.1312.9.camel@mindpipe>
	 <20050327032059.GA31389@kroah.com> <1111894220.1312.29.camel@mindpipe>
	 <20050327181056.GA14502@kroah.com>
	 <1111948631.27594.14.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > How about the fact that when you load a kernel module, it is linked into
> > the main kernel image?  The GPL explicitly states what needs to be done
> > for code linked in.
> >
> I've always wondered about dynamically loaded modules (and libraries for
> that matter).  The standard IANAL, but I've talked to many to try to
> understand what is really legal, and I usually come up with the
> conclusion, it's just an interpretation of the law by the judge.
> 
> If the user is loading the module (or library) and the distributer
> doesn't, then is the the user breaking the license and not the
> distributer?

I think this is probably what the lawyers are telling the graphics
card companies at the moment, the GPL is broken by the act of linking
and at what stage is the link considered to have happened, so if I
distribute a GPL or BSD licensed stub layer in source form, a big
binary blob that doesn't use any kernel interfaces except my stub
layer ones, and never distribute any of it with a kernel or linked
into anything, am I breaking the GPL on the kernel? all I'm doing is
releasing some source code and some binary image files, the user is
doing the linking by loading my code into their running kernel  and
I'm not distributing my code with the kernel...

It'll be an interesting day in court... and maybe then derived work
will become nicely defined at least for one country....

Dave.
