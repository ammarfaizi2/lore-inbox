Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTIUCJU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 22:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTIUCJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 22:09:20 -0400
Received: from port175.ds1-noe.adsl.cybercity.dk ([212.242.126.52]:28727 "EHLO
	kraftwerk.adsl.dk") by vger.kernel.org with ESMTP id S262283AbTIUCJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 22:09:19 -0400
Subject: Re: Badness in as_completed_request in 2.6.0-test5-bk3
From: Rene Rask <rene@grain.dk>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F6D0075.1000707@cyberone.com.au>
References: <1064055732.5913.15.camel@animatrix.klippegang.dk>
	 <3F6D0075.1000707@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1064110156.3832.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Sep 2003 04:09:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-09-21 at 03:35, Nick Piggin wrote:
> Rene Rask wrote:
> 
> >I'm not subscribed to the list so please cc me if you have questions.
> >
> >
> >>Try disabling TCQ, I don't think it is very stable for IDE drives.
> >>
> >
> >I'm getting these messages with a 3ware 7500-12 card as well even though
> >it is a scsi card.
> >I'm using kernel 2.6-test5-bk6 and copying files files an nfs mount to
> >the local 3ware disks ( 6 200 GB disks in hardware RAID5).
> >
> 
> No hangs though?
> 

No permanent hangs. If I "cat 4GB_file > /dev/null" I can't seem to stop
that process fast. If I kill it and wait a long time it will eventually
die.

I have copied 700 GB from another server with no other problems than
those log messages. 


