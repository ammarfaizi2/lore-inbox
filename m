Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbTBFXwT>; Thu, 6 Feb 2003 18:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbTBFXwT>; Thu, 6 Feb 2003 18:52:19 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:58385 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267353AbTBFXwR>; Thu, 6 Feb 2003 18:52:17 -0500
Date: Fri, 7 Feb 2003 01:01:01 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <linux-kernel@vger.kernel.org>, <jgarzik@pobox.com>
Subject: Re: [PATCH] Restore module support.
In-Reply-To: <20030206232515.GA29093@kroah.com>
Message-ID: <Pine.LNX.4.44.0302070037230.32518-100000@serv>
References: <20030204233310.AD6AF2C04E@lists.samba.org>
 <Pine.LNX.4.44.0302062358140.32518-100000@serv> <20030206232515.GA29093@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Feb 2003, Greg KH wrote:

> But what are the modutils numbers? :)

There should be no real difference as I'd like to integrate Kai's patch too.

> Come on, what Rusty did was the "right thing to do" and has made life
> easier for all of the arch maintainers (or so says the ones that I've
> talked to), and has made my life easier with regards to
> MODULE_DEVICE_TABLE() logic, which will enable the /sbin/hotplug
> scripts/binary to shrink a _lot_.

What was the "right thing to do"?
There were certainly a few interesting changes, but I'd like discuss them 
first. For example there is more than one solution to improve the 
MODULE_DEVICE_TABLE() logic (*), so how is Rusty's better?

bye, Roman

(*) http://marc.theaimsgroup.com/?l=linux-kernel&m=104405265719327&w=2
    http://marc.theaimsgroup.com/?l=linux-kernel&m=104437966220610&w=2

