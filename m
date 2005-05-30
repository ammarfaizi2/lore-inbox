Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVE3HaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVE3HaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 03:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVE3HaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 03:30:09 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:7865 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261537AbVE3HaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 03:30:05 -0400
Subject: Re: Playing with SATA NCQ
From: Erik Slagter <erik@slagter.name>
To: Mark Lord <liml@rtr.ca>
Cc: Michael Thonke <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <429A58F4.3040308@rtr.ca>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299F47B.5020603@gmail.com>
	 <1117387591.4851.17.camel@localhost.localdomain>  <429A58F4.3040308@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 30 May 2005 09:29:52 +0200
Message-Id: <1117438192.4851.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-29 at 20:06 -0400, Mark Lord wrote:
> > ICH6M (mobile/no raid) on a Dell Inspiron 9300 laptop. AFAIK there are
> > no plans to implement support for AHCI transition in the BIOS. &^$##($%
> > DELL.
> 
> No hope of it on this machine (I'm using a tricked-out i9300 here too),
> because (1) the HD is PATA, not SATA, and (2) the drive itself probably
> doesn't support NCQ (my 100GB drive does NOT -- use "hdparm -I" to see
> what is supported on any given drive.  libata-dev includes hdparm support).

I really have a (native) SATA drive, I checked the ID from dmesg.
