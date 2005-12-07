Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVLGOnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVLGOnb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVLGOnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:43:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22674 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750987AbVLGOnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:43:31 -0500
Message-ID: <4396F51C.8080902@volny.cz>
Date: Wed, 07 Dec 2005 15:43:40 +0100
From: Miloslav Trmac <mitr@volny.cz>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Yu, Luming" <luming.yu@intel.com>,
       Bernhard Rosenkraenzer <bero@arklinux.org>
CC: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [git pull 02/14] Add Wistron driver
References: <3ACA40606221794F80A5670F0AF15F840A53FD73@pdsmsx403>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840A53FD73@pdsmsx403>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yu, Luming wrote:
>>On second thought, do you by "found BIOS interfaces" mean "found BIOS
>>interfaces when asked to" or "matched the existing Aspire 1500 DMI ID"?
> 
> I found this in dmesg:
> 
> wistron_btns: BIOS signature found at c00f6920, entry point 000FDC10
> input: Wistron laptop buttons as /class/input/input2
OK, please attach the output of dmidecode (here or to #5692).
I have attached my acpidump there.

Bero, can you please test whether the ACPI hotkey driver would work for you?
If so, I'll remove the Acer Aspire 1500 entry.
If not, please attach the output of dmidecode too, we'll try to find out
how to differentiate between the laptops

Thanks,
	Mirek
