Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWBQHdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWBQHdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWBQHdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:33:13 -0500
Received: from anaconda.npgx.com.au ([203.14.211.27]:64402 "EHLO
	anaconda.npgx.com.au") by vger.kernel.org with ESMTP
	id S932305AbWBQHdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:33:13 -0500
From: "Michael Mansour" <mic@npgx.com.au>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: smartmontools-support@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [smartmontools-support]Re: WD 400GB SATA Drive In Constant Smart Testing?
Date: Fri, 17 Feb 2006 17:32:35 +1000
Message-Id: <20060217073115.M12621@npgx.com.au>
In-Reply-To: <Pine.LNX.4.61.0602140915030.7198@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0602130524350.13160@p34> <Pine.LNX.4.61.0602140915030.7198@yvahk01.tjqt.qr>
X-Mailer: Open WebMail 2.51 20050627
X-OriginatingIP: 203.14.211.3 (mic)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
X-NPGX-MailScanner-Information: Please contact NPGX for more information
X-NPGX-MailScanner: Found to be clean and virus free
X-NPGX-MailScanner-From: mic@npgx.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Is there some sort of smart testing going on constantly?  I only get 26-27MB/s
> 
> You can find out using `smartctl -data -a /dev/hdX`; if there is a 
> SMART test going on, there should be info about its status.
> 
> > #13  Vendor offline      Completed without error       00%         0 -
> > #14  Offline             Completed without error       00%         0 -
> > #15  Offline             Completed without error       00%         0 -
> > #16  Offline             Completed without error       00%         0 -
> > #17  Offline             Completed without error       00%         0 -
> > #18  Offline             Completed without error       00%         0 -
> > #19  Offline             Completed without error       00%         0 -
> > #20  Offline             Completed without error       00%         0 -
> > #21  Offline             Completed without error       00%         1 -
> >
> A little bit more below the values, usually.

Also, you may have to monitor this for a while as I've seen when a drive is
not recognised in the smartctl database, then it doesn't show it's progress,
only when it finishes checking does it show something in the selftest log.

Michael.
