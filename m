Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265962AbUFTWLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265962AbUFTWLg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUFTWLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:11:36 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:12435 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S265962AbUFTWL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:11:29 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Hannu Savolainen <hannu@opensound.com>
Cc: Valdis.Kletnieks@vt.edu, 4Front Technologies <dev@opensound.com>,
       linux-kernel@vger.kernel.org
Date: Sun, 20 Jun 2004 15:11:15 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Stop the Linux kernel madness 
In-Reply-To: <Pine.LNX.4.58.0406191148570.30038@zeus.compusonic.fi>
Message-ID: <Pine.LNX.4.60.0406201506360.6470@dlang.diginsite.com>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay><40D23701.1030302@opensound.com>
 <1087573691.19400.116.camel@winden.suse.de><40D32C1D.80309@opensound.com>
 <20040618190257.GN14915@schnapps.adilger.int><40D34CB2.10900@opensound.com><200406181940.i5IJeBDh032311@turing-police.cc.vt.edu><Pine.LNX.4.60.0406181326210.3688@dlang.diginsite.com>
 <Pine.LNX.4.58.0406191148570.30038@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Hannu Savolainen wrote:

> On Fri, 18 Jun 2004, David Lang wrote:
>
>> by the way there's useually a *version file in /etc that tells you what
>> version of a particular distro you are running on (or at least what it was
>> before it got tweaked)
> It's usually possible to figure out the distribution and version by
> looking at /etc/issue. However it's impossible to figure out who has made
> the kernel image. It's possible to identify Mandrake kernels and few
> others. However in general all kernel versions look the same.

ueing /etc/issue is a BAD idea, while that may work for completely 
unmodified systems, many companies require legalese be put in there.

> The current situation is that every company who like to ship open source
> drivers with their hardware will have to automatically detect large
> amount of kernel and distribution combinations and try to decide which
> kind of installation approach is needed. After everything is settled then
> some distribution changes it's interfaces and the circus begins once
> again. Finally when a change is made to the installation procedure then
> how to test if it still works with all 100 or 200 different systems and
> kernel images that have already been tested during past years.

or they need to go through the process of getting their driver included in 
the main kernel and these headaches go away.

> I think many persons reading this list don't realize that a significant
> number of Linux installations are still using 7.x or even 6.x versions of
> whatever distribution they had originally installed in the system.
> Companies doing Linux software (be it open source or closed source) need
> to support them in addition to the state of the art distributions. So
> would it be too much to ask that kernels based on the same major version
> do certain things in the same way.

it's less likly that the people running the 6.x distros are going to be 
installing the latest and greatest hardware that needs the new 
out-of-kernel driver, but if you think you need to create modules that 
will work with every kernel since 2.0 have fun.

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
