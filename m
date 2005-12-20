Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVLTStm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVLTStm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVLTStm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:49:42 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:39066 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750813AbVLTStl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:49:41 -0500
Date: Tue, 20 Dec 2005 10:49:35 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-Reply-To: <1135102197.2952.23.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.62.0512201047360.11093@qynat.qvtvafvgr.pbz>
References: <200512201428.jBKESAJ5004673@laptop11.inf.utfsm.cl><Pine.LNX.4.62.0512200951080.11093@qynat.qvtvafvgr.pbz>
 <1135102197.2952.23.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Arjan van de Ven wrote:

>> how many other corner cases are there that these distros just choose not
>> to support, but need to be supported and tested for the vanilla kernel?
>
> as someone who was at that distro in the time.. none other than XFS and
> reiserfs4.

good to hear, outsiders don't know these details. all we know is that some 
things aren't supported, but (without a lot of effort) don't know what 
things.

>> also for those who are arguing that it's only dropping from 6k to 4k, you
>> are forgetting that the patches to move the interrupts to a seperate stack
>> have already gone into the kernel, so today it is really 8k+4k and the
>> talk is to move it to 4k+4k.
>
> actually irq stacks aren't enabled with 8K stacks right now, so your
> statement isn't correct.

Ok, I stand corrected, I didn't look at the code, I was going on the 
memories of the discussions on l-k where the advocates were pushing to 
enable the interrupt stacks unconditionally, and I was remembering that a 
patch to do so had gone in.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

