Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUFRUi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUFRUi5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUFRUaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:30:15 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:57844 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261654AbUFRU3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:29:24 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Valdis.Kletnieks@vt.edu
Cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org
Date: Fri, 18 Jun 2004 13:29:11 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Stop the Linux kernel madness 
In-Reply-To: <200406181940.i5IJeBDh032311@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.60.0406181326210.3688@dlang.diginsite.com>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>
 <40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de>
 <40D32C1D.80309@opensound.com> <20040618190257.GN14915@schnapps.adilger.int><40D34CB2.10900@opensound.com>
 <200406181940.i5IJeBDh032311@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 18 Jun 2004 13:12:34 PDT, 4Front Technologies said:
>
>> We precisely use this mechanism - we use
>> /lib/modules/<version>/build/include/linux/config.h to figure such features out
>> but when the "build" part of the path doesn't point to the right source tree,
>> where do you look?. SuSE ships kernel sources "unconfigured" which means that
>> you have to rely on something else to tell you what the exact kernel
>> configuration looks like.
>
> Right, but hopefully you can tell it's a SuSE machine via other means, and
> then apply a suitable workaround.

the problem with this is that you can have the situation where it's a SuSE 
box with a kernel.org kernel. I've had significant problems with 
installers for 3rd party software that decided what distro they were 
running on based on what kernel version showed up in uname

by the way there's useually a *version file in /etc that tells you what 
version of a particular distro you are running on (or at least what it was 
before it got tweaked)

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
