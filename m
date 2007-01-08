Return-Path: <linux-kernel-owner+w=401wt.eu-S1030379AbXAHBlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbXAHBlB (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 20:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbXAHBlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 20:41:01 -0500
Received: from s233-64-196-242.try.wideopenwest.com ([64.233.242.196]:53502
	"EHLO echohome.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030379AbXAHBlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 20:41:00 -0500
Reply-To: <Erik@echohome.org>
From: "Erik Ohrnberger" <Erik@echohome.org>
To: <linux-kernel@vger.kernel.org>
Subject: RE: System / libata IDE controller woes (long)
Date: Sun, 7 Jan 2007 20:41:01 -0500
Organization: EchoHome.org
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAASPhcTp3AFGoVU+FXAXe2wBAAAAAA==@EchoHome.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.64.0612261442120.19760@p34.internal.lan>
Thread-Index: AccpJhmybUONOclCRtC4k/j1aiGcEQDCyngQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, after more mucking about, and copying data off of the production LVM
on to the backup LVM, I noticed that no matter where I put this one Seagate
drive, it caused dma_timer_expiry errors.  Once I replaced this drive,
everything settled down again, and has been running normally.

So it's not the old IDE driver code can't handle that many controllers, it
can.  It's also no problem for libata in a similar configuration.  Both work
and work well.

I have to admit that it sure took me a long time to figure out that the
drive was the problem.  I guess that sort of thing should move higher in the
diagnosis decision tree.  You live, you learn.

Thanks for everyone's patience and help in this.  It helped me keep my
sanity through all this.

Cheers,
	Erik.

