Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbUKENhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbUKENhp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUKENhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:37:45 -0500
Received: from imap3.nextra.sk ([195.168.1.92]:46864 "EHLO tic.nextra.sk")
	by vger.kernel.org with ESMTP id S262678AbUKENhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:37:40 -0500
Message-ID: <418B8239.6080108@rainbow-software.org>
Date: Fri, 05 Nov 2004 14:38:01 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "=?ISO-8859-1?Q?J=FCrgen_Erhard?=" <jae+vger.kernel@jerhard.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: CPU selection "typo"
References: <E1CQ3l3-00011j-00@sanctum.jerhard.org>
In-Reply-To: <E1CQ3l3-00011j-00@sanctum.jerhard.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jürgen Erhard wrote:
> In M586, it says "Intel 6x86MX", while there's no such thing, what it
> means is "*Cyrix* 6x86MX".
> 
> Hasn't been spotted for a year?  Probably since no-one uses such a
> beast anymore.
> 
> Bye, J
> 
I'm running Cyrix MII PR300 CPU, which is a bit newer than 6x86MX but I 
never noticed this :)

It says this:
Select this for an 586 or 686 series processor such as the AMD K5,
the Intel 5x86 or 6x86, or the Intel 6x86MX.  This choice does not
assume the RDTSC (Read Time Stamp Counter) instruction.

The "Intel 5x86 or 6x86, or the Intel 6x86MX" is wrong. Intel CPUs have 
their own CONFIG_ options. 6x86 and 6x86MX are Cyrix CPUs. AFAIK, the 
AMD 5x86 is 486-class CPU.
And I wonder if this is really the correct option for 6x86MX and MII 
CPUs...they have TSC and MMX.


-- 
Ondrej Zary
