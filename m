Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272158AbTG2VYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272221AbTG2VYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:24:03 -0400
Received: from [207.231.225.15] ([207.231.225.15]:44481 "EHLO mail")
	by vger.kernel.org with ESMTP id S272158AbTG2VWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:22:20 -0400
Message-ID: <3F26E592.4080302@infointeractive.com>
Date: Tue, 29 Jul 2003 18:22:26 -0300
From: Rob Shortt <rob@infointeractive.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA errors - 2.4.22-pre8 - SiS730 - WD800JB
References: <3F266B99.1040507@infointeractive.com> <20030729153309.A25792@bouton.inet6-interne.fr> <3F267BC4.8000507@infointeractive.com>
In-Reply-To: <3F267BC4.8000507@infointeractive.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Shortt wrote:
> Lionel Bouton wrote:
> 
>> Usually disabling local APIC support solves this (sometimes with nasty
>> side-effects like huge perf drops or lost peripheral support).
>>
>> You can quickly try to pass "noapic" to the kernel and report.

Done, same deal:

Kernel command line: root=/dev/hda1 ro noapic
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!


I guess I'll start searching for some SiS APIC patches.  Does anyone 
know if the 2.6 kernel has SiS APIC problems?

-Rob

