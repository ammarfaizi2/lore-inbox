Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263206AbVCDXIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbVCDXIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263278AbVCDWQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:16:59 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:61846 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263045AbVCDU6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:58:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MKTn8lZh1d8jgJJeGNKD1kBe4oDnGnxDCoj20e+/XXz1bdZhs7j8sYN3Qeuuup5wJKByIX4LB8G0mhxy6SRE9lbq0YY1XO0A/h1mTh1ExTZ9tclh79qeIrV1FEjT+1yXZpJKBJTF9EN6pTn9bvrd4XnlUeJlbpgMfuUoTS+sWYc=
Message-ID: <d91f4d0c050304125843dc1397@mail.gmail.com>
Date: Fri, 4 Mar 2005 15:58:43 -0500
From: George Georgalis <georgalis@gmail.com>
Reply-To: George Georgalis <georgalis@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: problem with linux 2.6.11 and sa
In-Reply-To: <d91f4d0c050304105339eb297d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050303184605.GB1061@ixeon.local>
	 <d91f4d0c0503031057306a74e1@mail.gmail.com>
	 <20050304043706.GA10336@havoc.gtf.org>
	 <d91f4d0c050304105339eb297d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005 13:53:50 -0500, George Georgalis <georgalis@gmail.com> wrote:
> On Thu, 3 Mar 2005 23:37:06 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> > On Thu, Mar 03, 2005 at 01:57:28PM -0500, George Georgalis wrote:
> > > I recall a problem a while back with a pipe from
> > > /proc/kmsg that was sent by root to a program with a
> > > user uid. The fix was to run the logging program as
> > > root. Has that protected pipe method been extended
> > > since 2.6.8.1?
> > >
> > > I'm very defiantly seeing a problem with the 2.6.11
> > > kernel and my spamassassin setup. However, it's not
> > > clear exactly where the problem is, seems like sa
> > > but it might be 2.6.11 with daemontools + qmail +
> > > QMAIL_QUEUE.
> >
> > Does reverting to 2.6.10 fix this behavior?
> 
> Yes, actually I revert to 2.6.8.1; will try 2.6.10 today...

I did make oldconfig (n,n,n) with my 2.6.11 .config
and seems to be working normal. Could
CONFIG_PREEMPT_BKL=y
have anything to do with it?

http://galis.org/linux-2.6.11-sta.config
http://galis.org/linux-2.6.10-sta.conf

// George
-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org
