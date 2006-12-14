Return-Path: <linux-kernel-owner+w=401wt.eu-S1751823AbWLNR7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWLNR7q (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbWLNR7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:59:46 -0500
Received: from ns.firmix.at ([62.141.48.66]:52969 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823AbWLNR7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:59:44 -0500
X-Greylist: delayed 1508 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 12:59:44 EST
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Bernd Petrovitsch <bernd@firmix.at>
To: =?ISO-8859-1?Q?Hans-J=FCrgen?= Koch <hjk@linutronix.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200612141847.03592.hjk@linutronix.de>
References: <20061213195226.GA6736@kroah.com>
	 <200612141056.03538.hjk@linutronix.de>
	 <1166117658.28664.105.camel@tara.firmix.at>
	 <200612141847.03592.hjk@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Organization: Firmix Software GmbH
Date: Thu, 14 Dec 2006 18:59:39 +0100
Message-Id: <1166119179.28664.110.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.41 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 18:47 +0100, Hans-Jürgen Koch wrote:
> Am Donnerstag, 14. Dezember 2006 18:34 schrieb Bernd Petrovitsch:
> > On Thu, 2006-12-14 at 10:56 +0100, Hans-Jürgen Koch wrote:
> > [....]
> > > A small German manufacturer produces high-end AD converter cards. He sells
> > > 100 pieces per year, only in Germany and only with Windows drivers. He would
> > > now like to make his cards work with Linux. He has two driver programmers
> > > with little experience in writing Linux kernel drivers. What do you tell him?
> > > Write a large kernel module from scratch? Completely rewrite his code 
> > > because it uses floating point arithmetics?
> > 
> > Find a Linux kernel guru/company and pay him/them for
> > -) an evaluation if it is "better" (for whatever better means) to port
> > the driver
> >      or write it from scratch and
> > -) do the better thing.
> 
> Good idea - whatever "porting" means. There are lots of Windows drivers out there

Yes, I didn't want to open that can of worms.

> that are also partly user space using that Kithara stuff. They have most of their
> driver in a dll. So that is similar to what we want with UIO - except that we 
> handle interrupts in a clean way, they don't.
> If you need to port such a driver, simply writing a kernel module and a user space
> library would change so much of the concept that you can start rewriting it from

Of course, if "better" means "as cheap as possible no matter what", this
is probably the way to go.
Tough luck if you get into technical problems .....

> scratch. And you'll have a large kernel module to maintain. OK, the guru/company
> can earn money with it, at least as long as the customer doesn't realize it is
> not the best solution for him.

Depending on the definition of "best".

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

