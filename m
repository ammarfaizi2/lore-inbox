Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290641AbSBLAav>; Mon, 11 Feb 2002 19:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290643AbSBLAal>; Mon, 11 Feb 2002 19:30:41 -0500
Received: from dsl-213-023-038-214.arcor-ip.net ([213.23.38.214]:29893 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290641AbSBLAae>;
	Mon, 11 Feb 2002 19:30:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: How to check the kernel compile options ?
Date: Tue, 12 Feb 2002 01:32:08 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020211140359.642A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020211140359.642A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16aQrh-0003lv-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 11, 2002 08:05 pm, Bill Davidsen wrote:
> On Mon, 11 Feb 2002, Daniel Phillips wrote:
> 
> > On February 9, 2002 07:15 pm, Bill Davidsen wrote:
> > > On Wed, 6 Feb 2002, Randy.Dunlap wrote:
> > > 
> > > > I still prefer your suggestion to append it to the kernel image
> > > > as __initdata so that it's discarded from memory but can be
> > > > read with some tool(s).
> > > 
> > > The problem is that it make the kernel image larger, which lives in 
> > > /boot on many systems. Putting it in a module directory, even if not a 
> > > module, would be a better place for creative boot methods, of which 
> > > there are many.
> > 
> > You don't seem to be clear on the concept of 'option'.
> 
> Did I miss discussion of an option to put it somewhere other than as part
> of the kernel? Sorry, I missed that.

It's a trick question?  The config option would let you specify that no 
kernel config information at all would be stored with or in the kernel.  No 
cost, no memory footprint.  And I would get to have the extra warm n fuzzy 
usability I tend to go on at such lengths about.  So we're both happy, right? 

I'd even remain happy if the option were set *off* by default.

-- 
Daniel
