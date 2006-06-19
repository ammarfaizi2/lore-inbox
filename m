Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWFSWTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWFSWTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWFSWTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:19:03 -0400
Received: from s233-64-196-242.try.wideopenwest.com ([64.233.242.196]:30132
	"EHLO echohome.org") by vger.kernel.org with ESMTP id S964954AbWFSWTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:19:00 -0400
Reply-To: <Erik@echohome.org>
From: "Erik Ohrnberger" <Erik@echohome.org>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver for PDC202XX
Date: Mon, 19 Jun 2006 18:18:47 -0400
Organization: EchoHome.org
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAIdWvHE4LIdGgJWKcd2w9I8BAAAAAA==@EchoHome.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060619150547.0b6213b1.akpm@osdl.org>
thread-index: AcaT7CBLMtFvb7L+RnyHCMfC28FjMAAAFIuw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good thing that I googled groups this thread.  I thought that I was the only
one that had this problem.

I've gone from three 133TX2 controllers, 5 80-GB drives in a RAID5, and 3
drives in drive linking (all managed by EVMS) to 2 controllers with just the
3 drive linking drives, and still get the mda_expiry error messages.

Last thing that I've done is to force the data drives to use UDMA2, with the
hope that it'll work around this problem.  May be working, as I've not had
an error in 24 hours of running the system, but then I'm not accessing the
drives either.  They are dismounted to protect the data.  Didn't matter
before, got the errors with just the smartd daemon checking up on the drive
health, but so far so good.

Regardless, count me as another one of the interested parties for a cure.
I've read the thread, and will prepare two current kernels, one using the
PDC202XX_NEW and one using the PDC202XX_OLD configuration options.  I'm
hoping that the PDC202XX_OLD will also resolve this issue.

Any further advice on how to work around this would be greatly appreciated.

Erik.

