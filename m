Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUHMX5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUHMX5K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbUHMX5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:57:10 -0400
Received: from web14928.mail.yahoo.com ([216.136.225.87]:26483 "HELO
	web14928.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267847AbUHMX4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:56:34 -0400
Message-ID: <20040813235630.89799.qmail@web14928.mail.yahoo.com>
Date: Fri, 13 Aug 2004 16:56:30 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though sysfs)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1092433428.25002.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know internally how to find the VGA cards using the PCI class. I
meant this in the context of how do you enumerate all of the VGA
devices in a domain from a user space app. What is the API for this?
What is the user space API for turning off all of the VGA devices in a
domain?

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Gwe, 2004-08-13 at 16:53, Jon Smirl wrote:
> > What should the API for this look like? We could add a VGA={0/1}
> > attribute to all the VGA devices in sysfs.
> > 
> > But then how do you:
> > 1) list all of the conflicting VGA devices in a domain?
> > 2) turn off all the VGA devices in a domain?
> 
> 1. Is part of the PCI specification since there is a PCI class for
> VGA video devices. 2 follows naturally from 1
> 
> 


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
