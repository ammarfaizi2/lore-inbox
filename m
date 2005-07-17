Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVGQULl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVGQULl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 16:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVGQULk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 16:11:40 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:25827 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261269AbVGQULk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 16:11:40 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc3-mm1: a regression
Date: Sun, 17 Jul 2005 22:11:56 +0200
User-Agent: KMail/1.8.1
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050715013653.36006990.akpm@osdl.org> <200507162330.18810.rjw@sisk.pl> <20050716143945.735906ce.akpm@osdl.org>
In-Reply-To: <20050716143945.735906ce.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507172211.56487.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 16 of July 2005 23:39, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > On Friday, 15 of July 2005 10:36, Andrew Morton wrote:
> >  > 
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> >  > 
> >  > (http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc3-mm1.gz until
> >  > kernel.org syncs up)
> > 
> >  There seems to be a regression wrt 2.6.13-rc3 which causes my box (Asus L5D,
> >  Athlon 64 + nForce3) to hang solid during resume from disk on battery power.
> > 
> >  First, 2.6.13-rc3-mm1 is affected by the problems described at:
> >  http://bugzilla.kernel.org/show_bug.cgi?id=4416
> >  http://bugzilla.kernel.org/show_bug.cgi?id=4665
> >  These problems go away after applying the two attached patches.  Then, the
> >  box resumes on AC power but hangs solid during resume on battery power.
> >  The problem is 100% reproducible and I think it's related to ACPI.
> 
> That recent acpi merge seems to have damaged a number of people...
> 
> Are you able to test Linus's latest -git spanshot?  See if there's a
> difference between -linus and -mm behaviour?

I was afraid you would say so. ;-)

The -rc3-git-[2-4] kernels are unaffected by the problem described, so it seems
to be specific to -rc3-mm1.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
