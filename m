Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbTFCQRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTFCQRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:17:31 -0400
Received: from imsantv30.netvigator.com ([210.87.253.77]:23520 "EHLO
	imsantv30.netvigator.com") by vger.kernel.org with ESMTP
	id S265071AbTFCQRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:17:30 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Marc Wilson <msw@cox.net>
Subject: Re: Linux 2.4.21-rc6
Date: Wed, 4 Jun 2003 00:30:27 +0800
User-Agent: KMail/1.5.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20030529052425.GA1566@moonkingdom.net> <20030529055735.GB1566@moonkingdom.net> <Pine.LNX.4.55L.0306031302310.3892@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0306031302310.3892@freak.distro.conectiva>
X-OS: GNU/Linux 2.5.70
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306040030.27640.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 00:02, Marcelo Tosatti wrote:
> On Wed, 28 May 2003, Marc Wilson wrote:
> > On Thu, May 29, 2003 at 06:34:48AM +0100, Riley Williams wrote:
> > > The basic problem there is that any mail client needs to know
> > > just how many messages are in a particular folder to handle that
> > > folder, and the only way to do this is to count them all. That's
> > > what takes the time when one opens a large folder.
> >
> > No, the basic problem there is that the kernel is deadlocking.  Read the
> > VERY long thread for the details.
> >
> > I think I have enough on the ball to be able to tell the difference
> > between mutt opening a folder and counting messages, with a counter and
> > percentage indicator advancing, and mutt sitting there deadlocked with
> > the HD activity light stuck on and all the rest of X stuck tight.
> >
> > And it just happened again, so -rc6 is no sure fix.  What did y'all that
> > reported the problem had gone away do, patch -rc4 with the akpm patches?
> > ^_^
>
> Ok, so you can reproduce the hangs reliably EVEN with -rc6, Marc?

-rc6 is better - comparable to 2.4.18 in what I have seen with my script.  

After the long obscure problems since 2.4.19x, -rc6 could use serious 
stress-testing. 

User level testing is not sufficient here - it's just like playing roulette.

By serious stress-testing I mean:

Everone testing comes up with  one dedicated "tough test" 
which _must_ be reproducible (program, script) along his line of 
expertise/application.

Two or more of these independent tests are run in combination.

This method should increase the coverage drastically.

Regards
Michael


