Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbUJ0Qyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbUJ0Qyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbUJ0Qv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:51:27 -0400
Received: from alog0717.analogic.com ([208.224.223.254]:63402 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262547AbUJ0QsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:48:07 -0400
Date: Wed, 27 Oct 2004 12:44:16 -0400 (EDT)
From: linux-os <root@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Andreas Klein <Andreas.C.Klein@physik.uni-wuerzburg.de>
cc: Sergei Haller <Sergei.Haller@math.uni-giessen.de>, Andi Kleen <ak@muc.de>,
       Andrew Walrond <andrew@walrond.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: solution Re: lost memory on a 4GB amd64
In-Reply-To: <Pine.LNX.4.58.0410271751330.3903@pluto.physik.uni-wuerzburg.de>
Message-ID: <Pine.LNX.4.61.0410271238180.6872@chaos.analogic.com>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409241315.42740.andrew@walrond.org> <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de>
 <200410221026.22531.andrew@walrond.org> <20041022182446.GA77384@muc.de>
 <Pine.LNX.4.58.0410231220400.17491@fb07-2go.math.uni-giessen.de>
 <20041023164902.GB52982@muc.de> <Pine.LNX.4.58.0410241133400.17491@fb07-2go.math.uni-giessen.de>
 <Pine.LNX.4.58.0410271704050.3903@pluto.physik.uni-wuerzburg.de>
 <Pine.LNX.4.58.0410271718050.10573@fb07-2go.math.uni-giessen.de>
 <Pine.LNX.4.58.0410271751330.3903@pluto.physik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Andreas Klein wrote:

>
> Hello,
>
> On Wed, 27 Oct 2004, Sergei Haller wrote:
>
>> On Wed, 27 Oct 2004, Andreas Klein (AK) wrote:
>>
>> Are you sure this is the same problem, that I have? You discovered
>> Problems with memtest86:
>>
>>> Memtest sees 0-2GB mem usable and 4-6GB unusable (complains
>>> about each memory address).
>>
>> I didn't:
>>
>>> memtest86 is happy with the memory.
>
> Memtest is happy with my memory too, if all 4 modules are installed in the
> slots belonging to CPU1. If I install 2 modules for each CPU, memtest86 is
> not happy anymore.
>

Could you please explain how memory is connected to only one
CPU? I don't think this is possible.

Is this board for some new multiple-CPU specification? It can't
work for SMP (symmetrical multiprocessor specification) unless
both CPUs can access the same RAM.

[SNIPPED...]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached and reviewed by John Ashcroft.
                  98.36% of all statistics are fiction.
