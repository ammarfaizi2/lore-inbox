Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbUKDAMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbUKDAMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUKDAIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:08:43 -0500
Received: from zamok.crans.org ([138.231.136.6]:49561 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261995AbUKDAFX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:05:23 -0500
To: Russell Miller <rmiller@duskglow.com>
Cc: Doug McNaught <doug@mcnaught.org>, Jim Nelson <james4765@verizon.net>,
       DervishD <lkml@dervishd.net>, Gene Heskett <gene.heskett@verizon.net>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net>
	<200411031733.30469.rmiller@duskglow.com>
	<877jp2sdfd.fsf@barad-dur.crans.org>
	<200411031756.30112.rmiller@duskglow.com>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Thu, 04 Nov 2004 01:05:22 +0100
In-Reply-To: <200411031756.30112.rmiller@duskglow.com> (Russell Miller's
	message of "Wed, 3 Nov 2004 18:56:30 -0500")
Message-ID: <87y8hiqy0t.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Miller <rmiller@duskglow.com> disait dernièrement que :

> On Wednesday 03 November 2004 17:47, Mathieu Segaud wrote:
>
>> this is because nfs related syscalls are not interruptible by default.
>> you can make them interruptible by mounting your nfs's with the 'intr'
>> option.
>
> That doesn't appear to work, then.  Because we do mount them with the intr 
> option, and the behavior doesn't seem to be any different.

weird, it works by here.... I can even umount() lost shares....

NFS is quite an unknown beast to me, sorry...
But it is clearly a bug, if you do mount them with -o intr...

-- 
<ajh> I always viewed HURD development like the Special Olympics of free software.

	- Is Hurd a opponent to Linux?

