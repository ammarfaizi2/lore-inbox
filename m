Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbVLOCrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbVLOCrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVLOCrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:47:19 -0500
Received: from mgate03.necel.com ([203.180.232.83]:31627 "EHLO
	mgate03.necel.com") by vger.kernel.org with ESMTP id S1030383AbVLOCrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:47:16 -0500
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rob Landley <rob@landley.net>, Pavel Machek <pavel@ucw.cz>,
       Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: ipw2200
References: <20051203135608.GJ31395@stusta.de>
	<200512102330.31572.rob@landley.net>
	<20051212173456.GB8209@paranoiacs.org>
	<200512121402.43957.rob@landley.net> <439DE10E.4080901@tmr.com>
	<20051212215203.GA8399@paranoiacs.org>
From: Miles Bader <miles.bader@necel.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 15 Dec 2005 11:38:53 +0900
In-Reply-To: <20051212215203.GA8399@paranoiacs.org> (Ben Slusky's message of "Mon, 12 Dec 2005 16:52:03 -0500")
Message-Id: <buopsnz6q4i.fsf@dhapc248.dev.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Slusky <sluskyb@paranoiacs.org> writes:
>> I confess I don't see the cpio as being easier to create.  You
>> presumably still want to include the modules from the fresh built
>> kernel, so creating a new cpio file would seem needed for most
>> people.
>
> cpio files are somewhat easier to create in that they can created by
> an unprivileged user. Most of the steps in making an initrd can only
> be done by root.

Initrds are also annoying because you have to guess/calculate a "disk"
size big enough to hold all the contents and inevitably waste some space
providing a margin for error.

Initrd seems at best a kind of kludge anyway; initramfs is just
all-around a cleaner concept.

-Miles
-- 
`To alcohol!  The cause of, and solution to,
 all of life's problems' --Homer J. Simpson
