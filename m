Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267066AbUBFAI4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267064AbUBFAIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:08:38 -0500
Received: from pop.gmx.de ([213.165.64.20]:37315 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267060AbUBFAIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:08:20 -0500
X-Authenticated: #4512188
Message-ID: <4022DAEE.2030109@gmx.de>
Date: Fri, 06 Feb 2004 01:08:14 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>,
       david+challenge-response@blue-labs.org,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <402298C7.5050405@wanadoo.es>	<40229D2C.20701@blue-labs.org>	<4022B55B.1090309@wanadoo.es> <20040205154059.6649dd74.akpm@osdl.org>
In-Reply-To: <20040205154059.6649dd74.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>What patches are you using?
>>
>>
>>I'm using nforce2-apic.patch and nforce2-disconnect-quirk.patch that 
>>Andrew Morton have sent to me. I think they have been included in 
>>previous mm kernels but now are droped because they caused some 
>>temperature problems for some people with no nforce motherboards.
> 
> 
> Yes, the patch which disables "Halt Disconnect and Stop Grant Disconnect"
> apparently causes the CPU to run hot.

Well, my temp is about 6-9°C hotter in idle mode, but with current 
kernels APIC (and no CPU diconnect) seems to be more stable than PIC and 
CPU Disconnect with my nforce. I at least don't have problems with 
forcedeth driver and current acpi.

>>By the way, is anyone involved in solving the IO-APIC thing in nforce 
>>motherboards? Anyone trying a different approach? Anyone contacting 
>>nvidia about this problem?
> 
> 
> As far as I know, we're dead in the water on these problems.

I remember Jesse Allan sending some lspci outputs to Bart to investigate 
the BIOS fix. I wonder what has happened to it. I tried to do a 
comparison with my values, but due to lack of some smart tools to show 
what is common and what is not (diff is not very suitable) it is very 
hard, esp if you have no knowledge about the actual meanings of those 
parameters.

Prakash

