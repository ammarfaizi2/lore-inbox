Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280735AbRKBRHs>; Fri, 2 Nov 2001 12:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280736AbRKBRHi>; Fri, 2 Nov 2001 12:07:38 -0500
Received: from air-1.osdl.org ([65.201.151.5]:52231 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S280735AbRKBRH0>;
	Fri, 2 Nov 2001 12:07:26 -0500
Message-ID: <3BE2D123.DAC9B571@osdl.org>
Date: Fri, 02 Nov 2001 09:00:19 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Yan, Noah" <noah.yan@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: vm documentation
In-Reply-To: <A9B0C3C90A46D411951400A0C9F4F67103BA56E3@pdsmsx33.pd.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yan, Noah" wrote:
> 
> Is there any resources(such as programming guide or referrence book) for the C language grammar in gcc, especially for Kernel? Such as what is _init, 1<<12, asmlinkage, etc?
> 
> 
> From: Robert Love [mailto:rml@tech9.net]
> 
> See http://kernelnewbies.org for some introduction to kernel hacking...


Noah,
Lots of your questions are appropriate for kernelnewbies.org .

__init (with 2 underscores) is defined in the header file
  linux/include/linux/init.h
It marks a code (text) segment as being discardable after boot/init
for code that is not in a module (i.e., it is compiled into the
kernel boot image).

"1<<12" is C.  Take the value 1, shift it left 12 times (bits),
giving 0x1000.

~Randy
