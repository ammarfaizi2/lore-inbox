Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbWBTTmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWBTTmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbWBTTmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:42:12 -0500
Received: from mail.gmx.de ([213.165.64.20]:55686 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932647AbWBTTmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:42:11 -0500
X-Authenticated: #31060655
Message-ID: <43FA1B90.2070505@gmx.net>
Date: Mon, 20 Feb 2006 20:42:08 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops during boot of 2.6.16-rc3-git7 on AMD64
References: <43F6678C.5080001@gmx.net> <p734q2w5nck.fsf@verdi.suse.de>
In-Reply-To: <p734q2w5nck.fsf@verdi.suse.de>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen schrieb:
> Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net> writes:
> 
> 
>>Hi,
>>
>>vanilla 2.6.16-rc3-git7 gives me the following oops during boot (most
>>of the time while mounting all filesystems) on my amd64 machine:
>>
>>(hand-written, no serial interface available)
>>Unable to handle kernel NULL pointer dereference at 00000008
>>rip: run_timer_softirq+322
>>process udev
>>Call trace:
>>__do_softirq+68
> 
> 
> Looks like someone is corrupting the timer list. Nasty. Can you do
> a binary search?
> 
> Or alternatively remove as many drivers as possible and narrow down
> which one is to blame.

Yes, will do that.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
