Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132244AbRBDUWF>; Sun, 4 Feb 2001 15:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132249AbRBDUV4>; Sun, 4 Feb 2001 15:21:56 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:27281 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S132244AbRBDUVq>; Sun, 4 Feb 2001 15:21:46 -0500
Message-ID: <3A7DB9C7.7D9C3751@Home.net>
Date: Sun, 04 Feb 2001 15:21:28 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PS hanging in 2.4.1 - More interesting things
In-Reply-To: <E14PMz2-0001NA-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, strangely, it stopped as it started?

I don't know what caused it to go loopy but then it just stopped. Im using:

syslogd -ver
syslogd 1.4-0

klogd -v
klogd 1.4-0

I thought this only affected older versions?

Shawn.

Alan Cox wrote:

> > Ok, I rebooted the system, then syslogd was using 100% cpu?
> > it seems like perhaps reiserfs is causing this problem??
>
> Typically it means your syslogd (klogd actually) is too old and has a bug that
> a 0 length printk causes it to spin.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
