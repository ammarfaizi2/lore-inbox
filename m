Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWKBWCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWKBWCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbWKBWCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:02:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:64081 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750961AbWKBWCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:02:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PV8/5uu/GPWDfm9nVVODQMFAMy1o8ZtHUJv2G/RnPxnpXgBtQ0w0m6vt6qnw2SeZLEUJXRTSvmqS94ehMChiRCWl7pRPCML0hHIcb4sFaJVJA63QxWq1RAIyqYRy1xke2hCw5kQkQ6P2aRnd96OYBCpDGZ9vKLnD0aHrypHO7UE=
Message-ID: <b637ec0b0611021401x2548b194s249b5d33aad782e4@mail.gmail.com>
Date: Thu, 2 Nov 2006 23:01:47 +0100
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "kernel list" <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc4 - tifm_7xx1 does not work after suspend-to-disk
Cc: "Alex Dubov" <oakad@yahoo.com>, "Pierre Ossman" <drzeus-mmc@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
The subject says it all: after a suspend-to-disk / resume cycle the
FlashMedia driver does not work at all: no message is logged in the
syslog and the SD card is not detected.

Normally this is what is logged in the syslog:

Nov  2 22:53:15 tycho kernel: tifm_7xx1: sd card detected in socket 3
Nov  2 22:53:15 tycho kernel: mmcblk0: mmc0:a95c SD256 247040KiB
Nov  2 22:53:15 tycho kernel:  mmcblk0: p1
Nov  2 23:00:33 tycho kernel: tifm_7xx1: demand removing card from socket 3

Any ideas?

Regards,
Fabio
