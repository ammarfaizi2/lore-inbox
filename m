Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVFOAwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVFOAwN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 20:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVFOAwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 20:52:12 -0400
Received: from one.firstfloor.org ([213.235.205.2]:55015 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261455AbVFOAwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 20:52:01 -0400
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: hpet patches
References: <88056F38E9E48644A0F562A38C64FB6004F7837A@scsmsx403.amr.corp.intel.com>
	<9e47339105061416365f4cd1eb@mail.gmail.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 15 Jun 2005 02:51:55 +0200
In-Reply-To: <9e47339105061416365f4cd1eb@mail.gmail.com> (Jon Smirl's
 message of "Tue, 14 Jun 2005 19:36:42 -0400")
Message-ID: <m1slzka1ck.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> writes:

> On 6/14/05, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
>> HPET device itself can be there. But, it can appear in different
>> addresses. Most commonly used address is 0xfed00000. But, it can be
>> different as well.
>
> Does Intel build different versions of something like an 82801EB with
> the HPET at different addresses and still have the same part number?

Sometimes the address can be configured in the chipset and HPET also
be disabled. So the only reliable way would be to check the chipset 
registers for each chipset. Unfortunately some are undocumented
(e.g. i've been trying to figure that out for Nvidia for quite some time
to no avail :/) 

-Andi
