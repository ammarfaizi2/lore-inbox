Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBEK0X>; Mon, 5 Feb 2001 05:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129480AbRBEK0M>; Mon, 5 Feb 2001 05:26:12 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:41997 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S129111AbRBEK0B>; Mon, 5 Feb 2001 05:26:01 -0500
Date: Mon, 5 Feb 2001 07:26:00 -0300
From: John R Lenton <john@grulic.org.ar>
To: Yan Li <uplot.liyan@sinohome.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bugs or other?
Message-ID: <20010205072600.A2765@grulic.org.ar>
Mail-Followup-To: Yan Li <uplot.liyan@sinohome.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010205095739.14575.qmail@uplot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010205095739.14575.qmail@uplot.com>; from uplot.liyan@sinohome.com on Mon, Feb 05, 2001 at 09:57:39AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2001 at 09:57:39AM -0000, Yan Li wrote:
> uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=3 (error=-110)

I got those on my (SMP) motherboard when I had my BIOS setting
for MPS at 1.4; changing it to 1.1 fixed the problem.

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
One picture is worth more than ten thousand words.
		-- Chinese proverb
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
