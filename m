Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267134AbTGOKop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 06:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267140AbTGOKop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 06:44:45 -0400
Received: from c213-100-44-190.swipnet.se ([213.100.44.190]:55827 "EHLO
	joelm.2y.net") by vger.kernel.org with ESMTP id S267134AbTGOKoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 06:44:44 -0400
Subject: Re: Inspiron 8000 makes high pitch noise only with 2.6.0-test1
From: Joel Metelius <joel.metelius@home.se>
To: Daniel.Dorau@alumni.TU-Berlin.DE
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3438.194.175.125.228.1058264884.squirrel@mailbox.TU-Berlin.DE>
References: <4299.194.175.125.228.1058254785.squirrel@mailbox.TU-Berlin.DE>
	 <1058258721.2423.2.camel@joelm.2y.net>
	 <3438.194.175.125.228.1058264884.squirrel@mailbox.TU-Berlin.DE>
Content-Type: text/plain
Message-Id: <1058266721.2716.3.camel@joelm.2y.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jul 2003 12:58:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it was discussed at LKML in May (search the archive around May 13).

I think the board idle the processor anyway, my dell latitude does it,
so you don't need linux to do it.

/joel

On Tue, 2003-07-15 at 12:28, Daniel.Dorau@alumni.TU-Berlin.DE wrote:
> Joel,
> thank you. I will try this. But doesn't this mean, that it will
> consume more power? My belief is that this had worked with
> 2.4 without that noise.
> You said it helped you and others. Has this been discussed on
> this or some other mailing list?
> 
> Thank you
> Daniel
> 
> > try turning off
> >
> > CONFIG_APM_CPU_IDLE
> >
> > it help me and others, but it had nothing to do with ethernet
> > drivers...
> 
> > /joel
> >
> > On Tue, 2003-07-15 at 09:39, Daniel.Dorau@alumni.TU-Berlin.DE wrote:
> >> Hi there,
> >> yesterday I tried the 2.6.0-test1 kernel for the first time.
> >> Installation went flawlessly. However I noticed a high pitch
> >> noise from my notebook everytime after the ethernet driver
> >> was loaded, no matter which one (eepro100 or e100).

