Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280410AbRKSXQK>; Mon, 19 Nov 2001 18:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280448AbRKSXQA>; Mon, 19 Nov 2001 18:16:00 -0500
Received: from N402P014.adsl.highway.telekom.at ([213.33.50.46]:18335 "HELO
	twinny.dyndns.org") by vger.kernel.org with SMTP id <S280410AbRKSXPz>;
	Mon, 19 Nov 2001 18:15:55 -0500
Message-ID: <3BF98FB3.B2713A09@webit.com>
Date: Tue, 20 Nov 2001 00:03:15 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB-OHCI + USB broken in 2.4.14/15pre2?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now, I found out how to work around the problem:

The only way seems to be rmmod usb-ohci on suspend, insmod at resume...

This isn't quite a nice way doing.... but it works.

Anyway, can anyone confirm that usb-ohci resumes correctly on similar
hardware? (SiS630 chipset, 2xSiS7001 USB controller)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria                  Check it out:         
mailto:tw@webit.com              *** http://www.webit.com/tw
