Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTI0EmW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 00:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTI0EmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 00:42:22 -0400
Received: from zero.aec.at ([193.170.194.10]:26635 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262111AbTI0EmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 00:42:21 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prefered method to map PCI memory into userspace.
From: Andi Kleen <ak@muc.de>
Date: Sat, 27 Sep 2003 06:42:16 +0200
In-Reply-To: <Aezg.6hA.9@gated-at.bofh.it> ("David S. Miller"'s message of
 "Sat, 27 Sep 2003 06:10:10 +0200")
Message-ID: <m3zngqhmfr.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <A8WS.6Uf.9@gated-at.bofh.it> <A8WR.6Uf.7@gated-at.bofh.it>
	<Aezg.6hA.9@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On 27 Sep 2003 00:03:42 +0200
> Andi Kleen <ak@suse.de> wrote:
>
>> mmap on /dev/mem
>> 
>> PIO cannot be done on memory, for that you have to use iopl() 
>> or ioperm() to get access to the port and then issue the PIO 
>> instructions yourself
>
> Platform dependant, mmap on /dev/mem doesn't work on many systems.

Just curious - what does the X server use on these many systems then ?

-Andi
