Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTAGBiv>; Mon, 6 Jan 2003 20:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTAGBiv>; Mon, 6 Jan 2003 20:38:51 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:62169 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S267260AbTAGBiu>;
	Mon, 6 Jan 2003 20:38:50 -0500
Subject: Re: [2.5.54 Bug]: in function zaurus_tx_fixup
From: Steven Barnhart <sbarn03@softhome.net>
To: Burton Windle <bwindle@fint.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.43.0301062040590.1994-100000@morpheus>
References: <Pine.LNX.4.43.0301062040590.1994-100000@morpheus>
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Jan 2003 20:47:20 -0500
Message-Id: <1041904051.26121.0.camel@sbarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 20:42, Burton Windle wrote:
> Do a
> grep -r "zaurus_tx_fixup" *
>  in your source tree, and you'll find a file which calls that function,
> and in that function, a reference to crc32_le
> 
> Most likely, it's in:
> 
> drivers/usb/net/usbnet.c:zaurus_tx_fixup
> 
thanks a lot. that's much better.
-- 
Steven
sbarn03@softhome.net
GnuPG Fingerprint: 9357 F403 B0A1 E18D 86D5  2230 BB92 6D64 D516 0A94

