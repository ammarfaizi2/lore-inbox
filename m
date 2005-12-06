Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVLFIiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVLFIiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 03:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVLFIiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 03:38:54 -0500
Received: from fmr18.intel.com ([134.134.136.17]:31972 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932085AbVLFIiy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 03:38:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [git pull 02/14] Add Wistron driver
Date: Tue, 6 Dec 2005 16:38:32 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840A53FD1F@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [git pull 02/14] Add Wistron driver
thread-index: AcX6PTGTjMKxa10GRNys7ft4E+EqyAAAvjiw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Miloslav Trmac" <mitr@volny.cz>
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 06 Dec 2005 08:38:33.0677 (UTC) FILETIME=[715E17D0:01C5FA40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Yu, Luming wrote:
>>>If your laptop provides the hotkey events via ACPI, simply don't use
>>>wistron_btns.
>> 
>> 
>> wistron driver should be disabled if acpi hotkey enabled.
>It is implicitly disabled because it contains DMI ids of known laptops,
>and its module_init() fails with -ENODEV when used on other hardware,
>before ever touching the BIOS.
>
>I therefore can't see how it could break anything unless you have
>explicitly supplied module parameters to override this check.
>	Mirek
>
My concern is if ACPI enabled those box could NOT work with Wistron
driver.
