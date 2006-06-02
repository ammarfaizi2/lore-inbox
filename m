Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWFBNXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWFBNXg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWFBNXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:23:36 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:7839 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1751405AbWFBNXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:23:36 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.0.166):SA:0(-102.3/1.7):. Processed in 5.311078 secs Process 20036)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Erik Mouw" <erik@harddisk-recovery.com>
Cc: <linux-kernel@vger.kernel.org>, <k.oliver@t-online.de>, <jes@sgi.com>
Subject: RE: __alloc_pages: 0-order allocation failed (Jes Sorensen)
Date: Fri, 2 Jun 2006 19:00:26 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMAEKKCNAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20060602122016.GC2051@harddisk-recovery.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your reply.

I anticipated that my application which was running perfectly on
linux-2.4.19-rmk7-pxa1 box will run as it is on linux-2.6.13 box as well.
But alas, this is not the case and I fail to understand why it is so? ;-(

~Abu.

-----Original Message-----
From: Erik Mouw [mailto:erik@zurix.bitwizard.nl]On Behalf Of Erik Mouw
Sent: Friday, June 02, 2006 5:50 PM
To: Abu M. Muttalib
Cc: linux-kernel@vger.kernel.org; k.oliver@t-online.de; jes@sgi.com
Subject: Re: __alloc_pages: 0-order allocation failed (Jes Sorensen)


On Fri, Jun 02, 2006 at 05:44:38PM +0530, Abu M. Muttalib wrote:
> I was running one application on a linux-2.4.19-rmk7-pxa1 box with 16 MB
RAM
> and 16 MB flash. It was all working fine.
>
> I am now trying to run the same application on a linux-2.6.13 box and
> intermittently I get OOM-KILLER and killing of a required process. What
has
> changed between these two kernel version?

Most of the VM subsystem, why do you ask...?

Try to recreate the problem with a more recent 2.6 kernel and post a
the kernel messages.


Erik

--
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

