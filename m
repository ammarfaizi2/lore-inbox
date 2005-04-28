Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVD1XPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVD1XPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 19:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVD1XPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 19:15:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:6791 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262311AbVD1XPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 19:15:35 -0400
In-Reply-To: <1114728218.18355.245.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: brace@hp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, mike.miller@hp.com
MIME-Version: 1.0
Subject: Re: [Question] Does the kernel ignore errors writng to disk?
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFDAC458FF.56F50513-ON88256FF1.007F29BD-88256FF1.007FD60F@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 28 Apr 2005 16:14:59 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/28/2005 19:15:34,
	Serialize complete at 04/28/2005 19:15:34
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>O_SYNC doesn't work completely on several file systems and only on the
>latest kernels with some of the common ones.

Hmmm.  You didn't mention such a restriction when you suggested fsync() 
before.  Does fsync() work completely on these kernels where O_SYNC 
doesn't?  Considering that a simple implementation of O_SYNC just does the 
equivalent of an fsync() inside every write(), that would be hard to 
understand.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems

