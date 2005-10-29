Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVJ2EHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVJ2EHG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 00:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVJ2EHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 00:07:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750833AbVJ2EHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 00:07:02 -0400
Date: Fri, 28 Oct 2005 21:06:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Boxer Gnome <aiko.sex@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: boot ok,but reboot hang, from 2.6.10 to 2.6.14
In-Reply-To: <174467f50510281926tfcbcc4bi@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0510282104500.3348@g5.osdl.org>
References: <174467f50510280544g5fffdfaeq@mail.gmail.com> 
 <Pine.LNX.4.64.0510280733000.4664@g5.osdl.org> <174467f50510281926tfcbcc4bi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Oct 2005, Boxer Gnome wrote:
>
> I tested the 2.6.10-rc1 and 2.6.10-rc2,the 2.6.10-rc1 rebooted ok,but
> the 2.6.10-rc2 has that problem.

Thanks. So it's between 2.6.10-rc1 and -rc2. Good. However:

> Then I test the snapshot
> 2.6.10-rc2-bk1,2.6.10-rc2-bk4,2.6.10-rc2-bk8,they all have this reboot
> hang.

Actually, you should test 2.6.10-rc1-bk*, not -rc2-bk*.

The "-bkxxx" kernels are not release-candidates, so they are not "before" 
the real release. They are nightly snapshots _after_ the release, so 
2.6.10-rc2-bk1 is the first snapshot after 2.6.10-rc2.

So you'd be interested in the ones after -rc1, but before -rc2.

		Linus
