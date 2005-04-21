Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVDUSOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVDUSOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVDUSOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:14:44 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:23958 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261599AbVDUSOl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:14:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NzsE9uhKIWGQG5rXMs+ZjoLoo6SpV8Ay9wUEmU7LfsWKOq+1RZIXXcLvoGeY+mR0NiB/Zj4tq50cohhkshvJQlr18S9LdGtKHg3UO2Wg1CHLuq3jTFqBd3jtjK4oMptPHBdyGXZNAw78JNZs/8qfEdNg2yuyQzqvD9n7qzxiiO0=
Message-ID: <2a4f155d05042111141e340cc1@mail.gmail.com>
Date: Thu, 21 Apr 2005 21:14:40 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: NForce4 ide problems?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2a4f155d05042022575553c2aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2a4f155d050420081220b3f801@mail.gmail.com>
	 <Pine.LNX.4.62.0504202142030.2071@dragon.hyggekrogen.localhost>
	 <2a4f155d05042022575553c2aa@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh well, this was due to bad cabling after all. A 80-conductor cable
fixed the issue.Thanks for heads up. Appreciated.

Regards,
ismail



On 4/21/05, ismail dönmez <ismail.donmez@gmail.com> wrote:
> Hi,
> 
> On 4/20/05, Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > You might want to post that Oops message if you want someone to try and 
> > fix it.
> > 
> 
> Ok see it below.
> 
> > Also, from your dmesg output I see that you are loading the NVIDIA module
> >  NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7174  Tue
> Mar
> > 22 06:45:40 PST 2005
> > You may want to try /not/ loading that module and then reproduce the 
> > kernel panic and then post that Oops or panic message instead.
> > 
> Ok this message was taken without loading nvidia module.
> 
> I get this just after hdparm command on /dev/hda :
> 
> <snip>
> CPU 0: Machine Check Exception: 4 Bank 4: b200000000070f0f
> TSC 1cb2201501c
> Kernel panic - not syncing : Machine check
> 
> </snip>
> 
> Any help is appreciated.
> 
> Regards,
> ismail
> 
> 
> -- 
> Time is what you make of it
> 

-- 
Time is what you make of it
