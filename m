Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263102AbVD3AmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbVD3AmI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbVD3AmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:42:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:11710 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263096AbVD3Aln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:41:43 -0400
In-Reply-To: <1114812035.18330.396.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: aia21@hermes.cam.ac.uk, Anton Altaparmakov <aia21@cam.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, linux-scsi-owner@vger.kernel.org,
       mike.miller@hp.com
MIME-Version: 1.0
Subject: Re: [Question] Does the kernel ignore errors writng to disk?
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF2CF58FEB.9B007265-ON88256FF3.000369D5-88256FF3.0003E37B@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 29 Apr 2005 17:41:29 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/29/2005 20:41:37,
	Serialize complete at 04/29/2005 20:41:37
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info on how stability works with SCSI and ATA, but I think 
you lost the context of my question.

You said earlier that fsync() and O_DIRECT are ways to deal with the 
problem of delayed write errors.  I added that O_SYNC is another way.  You 
then said that O_SYNC doesn't work completely correctly in some recent 
(but not current) kernels.  You didn't say the same about fsync().

I'd like to know if you mean to say that O_SYNC has some problems in some 
kernels that fsync() does not have.

And if it isn't too much trouble, it would be nice to hear details of how 
O_SYNC is partially correct in some kernels.

