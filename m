Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUALNX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 08:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266140AbUALNX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 08:23:28 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:19726 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265228AbUALNX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 08:23:26 -0500
Message-ID: <4002A296.4010305@aitel.hist.no>
Date: Mon, 12 Jan 2004 14:35:18 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: DervishD <raul@pleyades.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP or UP???
References: <200401121211.i0CCBg5u006677@harpo.it.uu.se> <20040112122538.GD18408@DervishD>
In-Reply-To: <20040112122538.GD18408@DervishD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi Mikael :)
> 
>  * Mikael Pettersson <mikpe@csd.uu.se> dixit:
> 
>>>kernel: found SMP MP-table at 000fb210
>>>   What, SMP table?
>>
>>You have an anti-problem. The chipset includes an I/O-APIC
>>(good) and your mobo manufacturer was decent enough to include
>>the appropriate BIOS MP tables to describe it to the OS.
> 
> 
>     Oh, nice. I thought that the mobo was a simple reisuing of a SMP
> mobo from Gigabyte with one socket removed O:)
> 
> 
>>Other manufacturers skip the MP table, forcing you to enable
>>ACPI and pray it actually works. 
> 
> 
>     Excuse my ignorance but: why a UP system needs the MP table? Why
> the I/O-APIC needs anything related with multiprocessor in an UP
> system?. I lost my way on hardware back in the 486, I think...
> 
The MP table tells the kernel details about that I/O-APIC.
(Advanced Programmable Interrupt Controller).

This isn't really about SMP, but every SMP board has
one or more APICs.  They have to.  It is optional
on a uniprocessor board, but it is nice to have as it
gives lower interrupt latency.

Helge Hafting

