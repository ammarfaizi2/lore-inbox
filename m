Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992712AbWJTTQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992712AbWJTTQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992714AbWJTTQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:16:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992712AbWJTTQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:16:15 -0400
Date: Fri, 20 Oct 2006 12:15:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: teunis <teunis@wintersgift.com>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Ingo Molnar <mingo@elte.hu>
Subject: Re: various laptop nagles - any suggestions?   (note:
 2.6.19-rc2-mm1 but applies to multiple kernels)
Message-Id: <20061020121537.dea13469.akpm@osdl.org>
In-Reply-To: <1161370015.5274.282.camel@localhost.localdomain>
References: <4537A25D.6070205@wintersgift.com>
	<20061019194157.1ed094b9.akpm@osdl.org>
	<4538F9AD.8000806@wintersgift.com>
	<20061020110746.0db17489.akpm@osdl.org>
	<1161368034.5274.278.camel@localhost.localdomain>
	<20061020112627.04a4035a.akpm@osdl.org>
	<1161370015.5274.282.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 20:46:55 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 2006-10-20 at 11:26 -0700, Andrew Morton wrote:
> > On Fri, 20 Oct 2006 20:13:54 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > > Also, NO_HZ breaks my laptop (and presumably quite a few others) quite
> > > > horridly, which means nobody can ship the feature.  Some runtime
> > > > turn-it-off work needs to be done there.
> > > 
> > > We can make a commandline switch as for highres. Is that sufficient ?
> > 
> > I doubt it.
> > 
> > I don't know how many machines will be affected by this, but I'd expect
> > it's quite a few - the Vaio has a less-than-one-year-old Intel CPU in it.
> 
> Is this still the broken lapic issue ?

yup.  iirc the standard FC5 SMP kernel runs dog-slowly on that machine too.

> I think about a detection
> mechanism for that one.

Thanks.
