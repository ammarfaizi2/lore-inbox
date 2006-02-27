Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbWB0H2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWB0H2u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWB0H2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:28:50 -0500
Received: from fmr23.intel.com ([143.183.121.15]:38123 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751634AbWB0H2t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:28:49 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: 2.6.16-rc4-mm2 configs
Date: Mon, 27 Feb 2006 02:28:39 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30062E9DD8@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc4-mm2 configs
Thread-Index: AcY7UaRDjzJpcgs9T9qdLLjoPTHw6gAHYmNw
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <rdunlap@xenotime.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Feb 2006 07:28:41.0460 (UTC) FILETIME=[6EE5CB40:01C63B6F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >> a.  why does SONY_ACPI default to m ?  Other similar options 
>> >are default n.
>> >
>> >Because I got heartily sick of losing the setting each time I 
>> >went back to a mainline kernel and did `make oldconfig'.
>> 
>> IIR the recommendation from Roman on these things was
>> to remove the default entirely.  If you have a favorite
>> .config file with =m in it, then make oldconfig should
>> preserve that choice.
>> 
>
>Nope.  Once you remove the Kconfig entry entirely (ie: go back to a
>mainline kernel), `make oldconfig' will rub that config entry out
>completely.

You're deleting the .config entirely and running "make oldconfig"
from scratch?

Hmmm, I always keep my sane .config around and run "make oldconfig"
on top of it in the context of the new kernel.  That preserves
my non-default selections.

-Len
