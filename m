Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289571AbSBSXKt>; Tue, 19 Feb 2002 18:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289790AbSBSXKk>; Tue, 19 Feb 2002 18:10:40 -0500
Received: from air-2.osdl.org ([65.201.151.6]:29194 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S289571AbSBSXKT>;
	Tue, 19 Feb 2002 18:10:19 -0500
Date: Tue, 19 Feb 2002 15:05:13 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Thomas Hood <jdthood@mail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4 PNPBIOS fault
In-Reply-To: <1014153713.5039.149.camel@thanatos>
Message-ID: <Pine.LNX.4.33L2.0202191501450.1465-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Feb 2002, Thomas Hood wrote:

| On Tue, 2002-02-19 at 13:48, Randy.Dunlap wrote:
| >
| > Linux 2.5.4 with PNPBIOS support enabled:
| >
| > Looks like a PnP BIOS fault to me (i.e., in the system
| > BIOS, not the kernel).
|
| I wrote:
| > Test by booting with "pnpbios=off".

Linux 2.5.4 with CONFIG_PNPBIOS=y and "pnpbios=off" oopses
in ahc_linux_isr() (or near there, according to the
System.map file).

| Also test by booting with "pnpbios=nores" and
| "pnpbios=nocurr".

Linux 2.5.4 with CONFIG_PNPBIOS=y and ("pnpbios=nores" or
"pnpbios=nocurr") dies with the same problem as posted in
the original email in this thread.

By changing only one config (to CONFIG_PNPBIOS=n), Linux 2.5.4
boots with no problems on this system.

-- 
~Randy

