Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263927AbRFFR0V>; Wed, 6 Jun 2001 13:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263885AbRFFR0L>; Wed, 6 Jun 2001 13:26:11 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:23306 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S263827AbRFFR0E>; Wed, 6 Jun 2001 13:26:04 -0400
Message-ID: <002e01c0eead$03c6d890$26040a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010605234928.A28971@lightning.swansea.linux.org.uk>
Subject: Re: Linux 2.4.5-ac9
Date: Wed, 6 Jun 2001 13:20:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.5-ac9

> o Fix xircom_cb problems with some cisco kit (Ion Badulescu)

I'm not sure what this is supposed to fix, but it makes my Xircom
RBEM56G-100 almost useless on my network at the office.  Actually, I can't
quite blame just this patch, it only makes the problem worse, the driver
from 2.4.5-ac3 worked, but with 1 second ping times, the new driver barely
works at all, it seems to think the link is not there, at least not enough
to pull an IP address.

The last driver that worked moderately well for me was the one from
2.4.4-ac11, it still had a few issues, mostly when resuming, but everything
worked at home on my 10Mb hub, and at the office on my 10/100Mb FD Cisco
6509.  I must admist that I haven't tested every version in between.

One other note, the version in 2.4.4-ac11 is listed as 1.33 while the
version in 2.4.5-ac9 is 1.11, why did we go backwards?  Were there
significant problems with the newer version?  The 1.33 sure seems to work
better for me.

Later,
Tom


