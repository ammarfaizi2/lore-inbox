Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284795AbRLXM36>; Mon, 24 Dec 2001 07:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284807AbRLXM3s>; Mon, 24 Dec 2001 07:29:48 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:46333 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S284795AbRLXM3j>; Mon, 24 Dec 2001 07:29:39 -0500
To: harri@synopsys.COM
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: Support for grub at installation time
In-Reply-To: <3C25ECBF.AF0E819C@Synopsys.COM>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 24 Dec 2001 13:27:26 +0100
In-Reply-To: <3C25ECBF.AF0E819C@Synopsys.COM> (Harald Dunkel's message of "Sun, 23 Dec 2001 15:39:59 +0100")
Message-ID: <m38zbsg5w1.fsf@giants.mandrakesoft.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel <harri@synopsys.COM> writes:

> It would be nice if you could consider this patch to be included in 
> one of the future kernels. I am not the kernel patch specialist, so 
> please excuse if I missed to follow a specific procedure.

Looking at your patch :

+ 	if [ -x /sbin/update-grub ]; then /sbin/update-grub; fi

This is distro specific. We should leave that job to installkernel up
to the vendors to customing it.
