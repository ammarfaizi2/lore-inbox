Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266630AbUHIOX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266630AbUHIOX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUHIOWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:22:04 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:25227 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S266626AbUHIOVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:21:20 -0400
Subject: Re: 2.6.8-rc2-mm1: bluetooth broken?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephane Jourdois <stephane@rubis.org>
Cc: Filip Van Raemdonck <filipvr@xs4all.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040809133452.GA24530@diamant.rubis.org>
References: <20040808191912.GA620@elf.ucw.cz>
	 <1092003277.2773.45.camel@pegasus> <20040809095425.GA12667@debian>
	 <1092046959.21815.15.camel@pegasus>
	 <20040809120705.GA23073@diamant.rubis.org>
	 <1092057843.21815.21.camel@pegasus>
	 <20040809133452.GA24530@diamant.rubis.org>
Content-Type: text/plain
Message-Id: <1092061267.4639.4.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 16:21:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

> > I never used a -mm patch, so you must be a little bit more specific what
> > is not working. What Bluetooth hardware are you using? Do the logfiles
> > or dmesg include anything helpful?
> 
> I use a usb dongle, unfortunately included in my laptop, so I can't see
> any serial number or anything.

I installed a 2.6.8-rc3-mm2 on my development machine and everything
works like it should. I tried a RFCOMM connection to my mobile, a HCRP
connection to my printer and I used a Bluetooth mouse. All stuff worked
perfect.

Do "hciconfig -a" show your Bluetooth device? Do "/proc/bus/usb/devices"
has an entry for it? Check "dmesg" for any USB related error messages.

Regards

Marcel


