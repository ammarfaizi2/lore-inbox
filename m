Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVAaU4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVAaU4U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVAaUyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:54:23 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:50312 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S261361AbVAaUwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:52:42 -0500
Date: Mon, 31 Jan 2005 21:52:35 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Bukie Mabayoje <bukiemab@gte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPMI smbus and Intel 6300ESB Watchdog drivers
Message-ID: <20050131205234.GC26992@hardeman.nu>
References: <20050130184401.GC3373@hardeman.nu> <41FD5EFB.D6E39F5E@gte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41FD5EFB.D6E39F5E@gte.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 02:26:03PM -0800, Bukie Mabayoje wrote:
>David Härdeman wrote:
>> 1) On the mainboard is a 6300ESB Watchdog Timer (pci id 8086:25ab), but
>> there seems to be no driver available for it.
>
>6300ESB is not a Watchdog Timer. It is an I/O Controller hub that includes a watch dog timer.

Ah well, I just quoted the output of lspci...

>> Does anyone know if there
>> is any such driver in progress or if I've misunderstood the situation?
>
>If you tell me why you are interested in the WDT, then maybe I will be able answer your question.

Hummm? In order to have watchdog functionality on the machine? But 
nevermind, I already got that question answered (with the pci id update 
for i8xx_tco).

>>
>>
>> 2) IPMI, Documentation/IPMI.txt mentions a ipmi_smb driver, but I could
>> find no such driver in the 2.6.10 tree. Am I missing something?
>
>Do you get the ISM package that shipped with the board? The ISM software stack in not part of the kernel. The IPMI stuff is part of Server Management.
>

As for IPMI, I have no idea, I just have no experience of it at all and 
I saw that this mmotherboard supported IPMI so I thought it could be an 
interesting experiment to learn a bit more about IPMI.

Re,
David
