Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUHVB4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUHVB4t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 21:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUHVB4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 21:56:49 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:21005 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S265091AbUHVB4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 21:56:46 -0400
Message-ID: <4127FD5A.90605@superbug.demon.co.uk>
Date: Sun, 22 Aug 2004 02:56:42 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonathan Bastien-Filiatrault <joe@dastyle.net>
CC: Lee Revell <rlrevell@joe-job.com>, Wakko Warner <wakko@animx.eu.org>,
       "David N. Welton" <davidw@dedasys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux Incompatibility List
References: <87r7q0th2n.fsf@dedasys.com>	 <20040821201632.GA7622@digitasaru.net> <20040821202058.GA9218@animx.eu.org> <1093120274.854.145.camel@krustophenia.net> <41282F4C.9060305@dastyle.net>
In-Reply-To: <41282F4C.9060305@dastyle.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Bastien-Filiatrault wrote:
>>
> Vendors should understand that ACTUALLY supporting linux means adopting 
> the free software philosophy. In many cases, vendors think that they 
> should be the only one to be able to write drivers, since 99% of desktop 
> users dont care about their software freedom. Vendors should not try to 
> obscure the workings of their devices, they should show the world how 
> they are innovating in hardware design by releasing specs on a 
> freely-redistributable basis. This would greatly improve competiveness 
> and innovation in the domain of hardware design. Give me a binary driver 
> and i will  buy from you once, give me the specs and i'll appreciate the 
> effort you put in designing the device.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

I remember a computer from pre ibm-pc days. It came with a manual that 
included a detailed circuit diagram, so the user could make any repairs 
they wished. It also gave details regarding CPU instruction set, and 
memory layout, so that anyone could write any OS they liked for it.

If we do create a nice long list, we should also include Linux 
compatible hardware as well.
E.g. Latest XYZ laptop, it would list all the chips in the laptop, 
together with what level of support linux has for each one.
The problem comes with actually identifying the parts.
For example, Creative have lots of different sound cards, all called the 
  SB Live, but they all have very different chips in them, with some 
supported by linux, and some not. Don't you just love those Marketing 
people. :-(
We can use PCI IDs and PCI subsystem IDs, to identify Motherboards, and 
PCI cards. We might also have to identify revision numbers.
We can use USB IDs to identify USB devices.

As an aid to this, I think we should create a script, that will gather 
the IDs in a consistent way, so that a user just runs the script, adds a 
comment, and submits it to the database.

