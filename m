Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWCHQnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWCHQnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWCHQnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:43:10 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33246 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932180AbWCHQnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:43:05 -0500
Subject: Re: LibPATA code issues / 2.6.15.4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: David Greaves <david@dgreaves.com>, Mark Lord <liml@rtr.ca>,
       Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus@lxorguk.ukuu.org.uk
In-Reply-To: <4406003A.1070606@cfl.rr.com>
References: <Pine.LNX.4.64.0602140439580.3567@p34>
	 <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34>
	 <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com>
	 <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34>
	 <4400A1B <1141238277.23170.2.camel@localhost.localdomain>
	 <4406003A.1070606@cfl.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 16:46:55 +0000
Message-Id: <1141836415.7605.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-03-01 at 15:12 -0500, Phillip Susi wrote:
> >>   It Broke And I Dont Know Why
> >> to
> >>   Aborted Command
> > 
> > So whats the SCSI sense encoding for that ?
> > 
> 
> Wouldn't that just be 0/0/0?  IIRC the standard defines that as "NO 
> ADDITIONAL SENSE DATA" which sounds to me like another way of saying "I 
> don't know what went wrong, but that didn't work".

The 0/0/0 sense is already used. The question is what error do you use
with that sense. At the moment I'm using aborted command.

