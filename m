Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVLLVwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVLLVwL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVLLVwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:52:10 -0500
Received: from lizards-lair.paranoiacs.org ([216.158.28.252]:39637 "EHLO
	lizards-lair.paranoiacs.org") by vger.kernel.org with ESMTP
	id S1751317AbVLLVwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:52:09 -0500
Date: Mon, 12 Dec 2005 16:52:03 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rob Landley <rob@landley.net>, Pavel Machek <pavel@ucw.cz>,
       Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: ipw2200 [was Re: RFC: Starting a stable kernel series off the 2.6 kernel]
Message-ID: <20051212215203.GA8399@paranoiacs.org>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Rob Landley <rob@landley.net>, Pavel Machek <pavel@ucw.cz>,
	Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
	David Ranson <david@unsolicited.net>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Matthias Andree <matthias.andree@gmx.de>
References: <20051203135608.GJ31395@stusta.de> <200512102330.31572.rob@landley.net> <20051212173456.GB8209@paranoiacs.org> <200512121402.43957.rob@landley.net> <439DE10E.4080901@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439DE10E.4080901@tmr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2005 15:43:58 -0500, Bill Davidsen wrote:
> Rob Landley wrote:
> I haven't tried that, since I use initrd files and have the kernel 
> support, but I confess I don't see the cpio as being easier to create. 
> You presumably still want to include the modules from the fresh built 
> kernel, so creating a new cpio file would seem needed for most people.

cpio files are somewhat easier to create in that they can created by an
unprivileged user. Most of the steps in making an initrd can only be done
by root.

-- 
Ben Slusky                      |    You must be smarter than 
sluskyb@paranoiacs.org          | <= this stick to ride the
sluskyb@stwing.org              |    internet.
PGP keyID ADA44B3B      
