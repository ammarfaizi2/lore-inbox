Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293267AbSB1Kix>; Thu, 28 Feb 2002 05:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293256AbSB1Kgj>; Thu, 28 Feb 2002 05:36:39 -0500
Received: from [213.38.169.194] ([213.38.169.194]:55819 "EHLO
	proxy.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id <S293255AbSB1Kep>; Thu, 28 Feb 2002 05:34:45 -0500
Message-ID: <AFE36742FF57D411862500508BDE8DD004639D22@mail.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: ext3 and undeletion
Date: Thu, 28 Feb 2002 10:37:22 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James D Strandboge wrote:

> However, for unlink there wouldn't be a big I/O problem in getting the
> items into .undelete-- we are just changing links.  It should be
> relatively easy to implement, not very intrusive, should be useful in
> the general case (rm and gui apps) and won't cause the disk 
> to fill up.
> 
> Jamie

That's definitely better than nothing.  Now all we need to do is keep
track of deletion time and which user did the deletion.  Which will
give us the same functionality that NetWare offers.  Last week I had
to salvage hundreds of files from a Netware 5.1 server after a careless
user had deleted a substantial directory tree.  Without being able to
sort by deletion time by job would have been a lot harder.  And yes,
I recovered a lot of files which had been changed since the previous
night's backup.

Cheers,

Phil
---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK
