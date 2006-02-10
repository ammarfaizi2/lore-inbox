Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWBJMhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWBJMhZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWBJMhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:37:24 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:64220 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751248AbWBJMhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:37:20 -0500
Date: Fri, 10 Feb 2006 13:37:14 +0100
From: Voluspa <lista1@telia.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16-rc2] Error - nsxfeval - And uncool silence from kernel
 hackers.
Message-Id: <20060210133714.1863aab5.lista1@telia.com>
In-Reply-To: <20060210042419.GA27457@kroah.com>
References: <20060210000101.2f028801.lista1@telia.com>
	<20060209233233.GB23971@kroah.com>
	<20060210035051.55dbb74a.lista1@telia.com>
	<20060210042419.GA27457@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2006 20:24:19 -0800 Greg KH wrote:
> On Fri, Feb 10, 2006 at 03:50:51AM +0100, Voluspa wrote:
> > On Thu, 9 Feb 2006 15:32:33 -0800 Greg KH wrote:
> > > On Fri, Feb 10, 2006 at 12:01:01AM +0100, Voluspa wrote:
> > > > 
> > > > Booted 2.6.16-rc2 on my AMD x86_64 notebook and saw something new in the
> > > > log (different from 2.6.15):
> > > 
> > > So, 2.6.16-rc2 works just fine, with out your reversal of that one
> > > patch?
> > 
> > Eh, I bundled two issues in my rant. 1) nsxfeval, which the ACPI guys
> > have confirmed is pure noise and can be forgotten. 2) "PCI: Failed to
> > allocate mem resource" which has been there since the commit I pointed
> > to, and never has effected the machine negatively (as far as I can tell).
> > So yes, 2.6.16-rc2 seems fine, and I don't patch it for that PCI thing.
> > It's just that the message is present and will worry people 'forever'
> > if nothing is done.
> 
> As long as everything is working properly, you can happily ignore the
> issue and blame your bios vendor for making such a stupid mistake :)

The issue came bouncing in from fedora-list to lkml. I've never cared one
way or the other. And while I have no love for a BIOS maker (Phoenix) that
only give you options like "Are you happy with the settings as is: Yes/Yes",
the occasional kernel hacker has also been seen wearing brown paper bags.

Something like a quirk/white/black-list could be used to make it invisible.
But as I said, me not really care (and neither do you ;-) So let's just
bury this thread.

Mvh
Mats Johannesson
--
