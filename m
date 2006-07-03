Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWGCLoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWGCLoV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 07:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWGCLoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 07:44:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:26532 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751129AbWGCLoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 07:44:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gpzjTPn76elR4RlULT8aAXwxkyzqF6IVgavNYoCU5J3nXYMnzdxrolL2AZCr3bz5mnqbf8MgaQfetCmEqwsf/d7LRlrUBC36ZLa+3mLVyFHvkUYa6E54sNF7gJMxkyshPq5Hv2sKfCxb30LQPOBKad369VpmfXfS9NW1tGDXUSw=
Message-ID: <44A9030A.1020106@gmail.com>
Date: Mon, 03 Jul 2006 14:44:10 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060620)
MIME-Version: 1.0
To: Daniel Bonekeeper <thehazard@gmail.com>
CC: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
In-Reply-To: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/06, Daniel Bonekeeper <thehazard@gmail.com> wrote:
> Hello everybody.
>
> I would like to develop a driver for any kind of fingerprint reader
> that currently doesn't have a driver for linux, and I'm open for
> suggestions on which device I should use. My first thought was the
> microsoft usb fingerprint reader
> (http://www.geeks.com/details.asp?invtid=DG2-00002-DT&cpc=SCH) because
> it's a new device (and, of course, doesn't have any driver for linux),
> it's cheap, and it's from MS (read "would be fun" =)

Please consider UPEK reader.
It is available on all new Thinkpad laptops, and the vendor 
provides
only binary drivers.

http://www.upek.com/support/dl_linux_bsp.asp

I hate when vendors like ATI, Conexant and UPEK publish 
binary drivers
without publishing the chipset spec... They should decide 
whether
their IP is on the software part or on the hardware part, if 
it is on
the hardware part, they are making money in selling the 
hardware. If
it is on the software part, there is no reason why not 
providing the
information for others to write software to work with the 
primitive
hardware. So in either case there should be full hardware 
interface
disclosure.

Best Regards and Goodluck!
Alon Bar-Lev.

