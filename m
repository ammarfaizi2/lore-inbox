Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUKLNTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUKLNTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 08:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbUKLNTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 08:19:20 -0500
Received: from iPass.cambridge.arm.com ([193.131.176.58]:27014 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261604AbUKLNTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 08:19:16 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: David Roundy <droundy@abridgegame.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] darcs mirror of the linux kernel repository
References: <20041110124158.GD31123@abridgegame.org>
	<20041111211924.GA1470@elf.ucw.cz>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 12 Nov 2004 13:19:50 +0000
In-Reply-To: <20041111211924.GA1470@elf.ucw.cz> (Pavel Machek's message of
 "Thu, 11 Nov 2004 22:19:27 +0100")
Message-ID: <tnxis8bqk5l.fsf@arm.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:
>> In brief, you can get a copy of the latest kernel (converted from the bkcvs
>> branch) using
>
> Would it be possible to get data from www.bkbits.net so that complete
> history is preserved?

I think in the past Larry stated that people should not use the
www.bkbits.net site for retrieving patches (understandable, it
increases the bandwidth usage). But he could use the bk-commits list,
only that I'm not sure all the patches can be cleanly applied in the
order they are posted.

BKCVS has a problem with the timestamps and cvsps cannot be used
properly - in the same changeset, some files can have a timestamp
different by exactly one hour, cvsps generating two patches (with
other patches generated between). For example, the logical change
1.24006 has the modification time for arch/i386/kernel/process.c
22:45:49 but for the rest of the files it is 21:45:49.

Could this get fixed? (I hope it is not intentional :-) )

Catalin

