Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWAPPvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWAPPvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWAPPvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:51:24 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:52937 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751049AbWAPPvY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:51:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aQz47FyHaXW0WSKpFUKuF4P7f0en5dzJSMoc/qLDAh8yne1a2gqmzoEL7KPkzSx1PuCbp3FHAmuWAETIN/Mr1ZR2ARcYBXI0CuMa0RHb3qu/538ecwFFLM0B+GbFsAbqDESGKescaflVr4CZkBCS7AB00Gs+DlcBWwxx85hcEiU=
Message-ID: <6e6e20a10601160751v362d2312v6c99fa8db64ce7e1@mail.gmail.com>
Date: Mon, 16 Jan 2006 16:51:22 +0100
From: =?ISO-8859-1?Q?Bj=F6rn_Nilsson?= <bni.swe@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 3COM 3C940, does not work anymore after upgrade to 2.6.15
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem with the network card attached to my motherboard
after doing an upgrade of the kernel from 2.6.11 to 2.6.15.

The Motherboard is an ASUS P4P800, and the network card is 3COM 3C940
and is afaik a variant of SysKonnect SK-98xx.

It worked with 2.6.15 until I shut the system down and started it up
again for the first time with 2.6.15 running, and now the card does
not work anymore. The driver is loaded, and it detects that the cable
is plugged in and the interface is brought up (so says dmesg). The
green led on the card is now turned off, it used to be on before.

I have tried to reinstall the system from scratch (Using Debian 3.1
installer cd), and to my astonishment the card is not working like it
used to.

It seems like 2.6.15 set the card in some state so it does not work
anymore. Is this even possible? I have tried power cycling, even
disconnected the power coord from the computer.

When i used 2.6.11 I was using the sk98lin driver, when upgrading it
is possible the newer skge driver was used, however I am not sure.

Debian installer 3.1 uses 2.6.8 kernel with sk98lin driver.

I have found others with the same/similar problem:
http://bugs.gentoo.org/show_bug.cgi?id=100258
http://marc.theaimsgroup.com/?l=linux-netdev&m=112268414417743&w=2

But for me the card does not work even with 2.6.15. I dont have
Wind*ws to test with, so I cant test the solution in one of the above
emails.

If the driver in 2.6.15 breaks cards of this type it is qiute a
serious bug I think. Anyone have any suggestions as to how I can try
to fix this? Reset the card in some way maybe?

Please CC me.

Regards
/Björn
