Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWC1N3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWC1N3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWC1N3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:29:07 -0500
Received: from javad.com ([216.122.176.236]:53772 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S932165AbWC1N3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:29:05 -0500
From: Sergei Organov <osv@javad.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Artem B. Bityutskiy" <dedekind@yandex.ru>, <linux@horizon.com>,
       <kalin@thinrope.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Lifetime of flash memory
References: <20060326162100.9204.qmail@science.horizon.com>
	<4426C320.9010002@yandex.ru>
	<20060327161845.GA16775@csclub.uwaterloo.ca>
	<Pine.LNX.4.61.0603271242100.16721@chaos.analogic.com>
	<87acbb6vlj.fsf@javad.com>
	<Pine.LNX.4.61.0603280737210.21370@chaos.analogic.com>
Date: Tue, 28 Mar 2006 17:27:33 +0400
In-Reply-To: <Pine.LNX.4.61.0603280737210.21370@chaos.analogic.com>
	(linux-os@analogic.com's message of "Tue, 28 Mar 2006 07:55:32 -0500")
Message-ID: <87vety66nu.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> On Mon, 27 Mar 2006, Sergei Organov wrote:
>
>> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
>> [...]
>>> CompactFlash(tm) like SanDisk(tm) has very good R/W characteristics.
>>
>> Try to write 512-byte sectors in random order, and I'm sure write
>> characteristics won't be that good.
>>
>>> It consists of a connector that exactly emulates an IDE drive connector
>>> in miniature, an interface controller that emulates and responds to
>>> most IDE commands, plus a method of performing reads and writes using
>>> static RAM buffers and permanent storage in NVRAM.
>>
>> Are you sure they do have NVRAM? What kind of NVRAM? Do they have backup
>> battery inside to keep NVRAM alive?
>>
>
> NVRAM means [N]on-[V]olatile-[RAM]. Any of many types, currently NAND flash.
> No battery required.

But NAND FLASH, while it is NV(Non-Volatile) *is not* RAM (Random Access
Memory), sorry. So it seems there is no NVRAM inside CFs, right?

-- Sergei.
