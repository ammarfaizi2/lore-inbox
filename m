Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289764AbSBLQko>; Tue, 12 Feb 2002 11:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289663AbSBLQke>; Tue, 12 Feb 2002 11:40:34 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:12551 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289102AbSBLQkY>; Tue, 12 Feb 2002 11:40:24 -0500
Date: Tue, 12 Feb 2002 11:38:56 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <E16aQrh-0003lv-00@starship.berlin>
Message-ID: <Pine.LNX.3.96.1020212113237.5657B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Daniel Phillips wrote:

> On February 11, 2002 08:05 pm, Bill Davidsen wrote:

> > Did I miss discussion of an option to put it somewhere other than as part
> > of the kernel? Sorry, I missed that.
> 
> It's a trick question?  The config option would let you specify that no 
> kernel config information at all would be stored with or in the kernel.  No 
> cost, no memory footprint.  And I would get to have the extra warm n fuzzy 
> usability I tend to go on at such lengths about.  So we're both happy, right? 
> 
> I'd even remain happy if the option were set *off* by default.

No trick other than to read what I said in either of the previous posts...
the question was not how to avoid having the useful feature, but how to
put it somewhere to avoid increasing the kernel size. I suggested in the
modules directory, either as a text file or as a module.

Disabling the feature is not the same as making it work optimally.

I like making it a module because it's obvious that modules_install is
needed. I see zero added utility from having it part of the kernel or
nothing, it's useful even to people booting from ROM, small /boot
partitions, etc.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

