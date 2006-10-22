Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422927AbWJVCBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422927AbWJVCBi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 22:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422929AbWJVCBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 22:01:37 -0400
Received: from ns.suse.de ([195.135.220.2]:15594 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422927AbWJVCBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 22:01:37 -0400
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PAE broken on Thinkpad
References: <1161472697.5528.6.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 22 Oct 2006 04:01:34 +0200
In-Reply-To: <1161472697.5528.6.camel@localhost.localdomain>
Message-ID: <p73mz7pm7lt.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> writes:

> Yea. So I know I probably shouldn't run a PAE kernel on my 1Gig laptop,
> but in trying to do so I found it won't boot.

You don't say what version?


> Int 14: CR2 c1000000  err 00000002  EIP c065d950 CS 00000060 flags 00010006
> Stack: c08b3000 00038000 00001000 00000020 c068f5c0 ffffffc0 fffffc2e 00000001
> 
> 
> >From gdb that EIP looks to be in __alloc_bootmem_core (string.h:372)

string.h??

-Andi
