Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUJMFOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUJMFOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268355AbUJMFOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:14:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:24222 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268206AbUJMFOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:14:48 -0400
Message-ID: <416CB8FC.9020503@osdl.org>
Date: Tue, 12 Oct 2004 22:11:24 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Raj <inguva@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Build problems with APM/Subarch type
References: <b2fa632f04101204385c09459f@mail.gmail.com>
In-Reply-To: <b2fa632f04101204385c09459f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raj wrote:
> I have been trying to build a 2.6.9-rc4. My box is an Intel P4.
> 
> Did all the configuration properly, except that i fumbled on the keyboard and
> the option 'Subarchitecture Type' somehow got set to
> '(SGI 320/540 Visual Workstation)'.

Using an editor or make *config?  which *config?

> The build failed with an error 'Undefined reference to machine_real_restart'

Yep, I see that also.

> It seems that , unless Subarch is PC-Compatible ( CONFIG_PC ) , 
> CONFIG_X86_BIOS_REBOOT will not be set and thusly, reboot.c would not be
> compiled.
> 
> ( yeah, i know messing around with configs is suicidal, but.... )
> 
> Can this be fixed ?? At the very least, hide APM options #if !(CONFIG_PC) ??

Do you/we/maintainer know that APM is not applicable to all of the
other PC sub-arches?

I agree that it should be fixed, one way or another.
-- 
~Randy
