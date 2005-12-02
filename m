Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVLBULU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVLBULU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVLBULU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:11:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26044 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751026AbVLBULS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:11:18 -0500
Message-ID: <4390AA5C.7030602@volny.cz>
Date: Fri, 02 Dec 2005 21:11:08 +0100
From: Miloslav Trmac <mitr@volny.cz>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Yu, Luming" <luming.yu@intel.com>
CC: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 
References: <3ACA40606221794F80A5670F0AF15F84041AC237@pdsmsx403>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC237@pdsmsx403>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yu, Luming wrote:
> I just tested module wistron_btn on  one Acer Aspire laptop after 
> adding one dmi entry.  The wistron_btn found BIOS interfaces.
> One visible error is the bluetooth light won't turn on upon 
> stroking bluetooth button.
> Without wistron_btn module, the bluetooth light works.
>  with acpi enabled, I didn't try acpi disabled)
> 
> wistron_btn polls a cmos address to detect hotkey event.  It 
> is not necessary, because there do have ACPI interrupt triggered upon 
> hotkeys.
There are many different laptops using similar interfaces.
It is a mess :(

If your laptop provides the hotkey events via ACPI, simply don't use
wistron_btns.

> So, my suggestion is to disable this module when ACPI enabled.
I have a laptop that needs this module (hotkeys are not supported via
ACPI), but supports ACPI.
	Mirek
