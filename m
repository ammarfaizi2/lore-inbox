Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWBNQxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWBNQxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWBNQxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:53:07 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:8377 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422647AbWBNQxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:53:05 -0500
Subject: Re: [PATCH 0/5] new dasd ioctl patchkit
From: Horst Hummel <horst.hummel@de.ibm.com>
Reply-To: horst.hummel@de.ibm.com
To: Christoph Hellwig <hch@lst.de>
Cc: kernel <linux-kernel@vger.kernel.org>, heiko <heicars2@de.ibm.com>,
       Stefan Weinhuber <wein@de.ibm.com>, Martin <mschwid2@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 17:53:08 +0100
Message-Id: <1139935988.6183.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here's a new patchkit to fix the dasd ioctl mess, against
> 2.6.16-rc2-mm1. I've built an s390 crosscompiler to compile-test them
and
> I've booted the resulting kernel with a debian image in hercules (not
that
> this excercises the ioctl path a whole lot, but I didn't find tools
that
> actually used any of these ioctls).
>
Thanks for doing some test this time. 
If I got that right, there is no big difference related to your last
proposal.

Unfortunately neither me nor Stefan W. got an answer on the question
about being more precise on 'ioctl mess' or any other statements
like 'adds more junk to already crappy code'.

We can't see - and you did not specify - reasons why the current
approach does not work. Therefore I don't see any urgency to change
that NOW instead of discuss the design change (consulting Martin - 
he will be back next week) and do the ioctl change when we have an 
agreed solution including ALL components. 

I agree that you proposal is straight forward and looks more pretty,
but I don't like the approach to just delete code that doesn't fit
your ideas.

As already mentioned we are currently working on a solution to move
the whole cmb-code out of the DASD device driver. 
In addintion I talked to Stefan W. and he is doing some evalutation
about possible solution for the eer_module on how adapt that module
to your proposal while keeping the functionality. 

As I already said, I would like to wait for final solution and 
don't apply the patches NOW.

regards
Horst Hummel

