Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268704AbUIGWZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268704AbUIGWZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268703AbUIGWZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:25:58 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:12459 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S268704AbUIGWZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:25:55 -0400
Subject: Re: software-suspend-2.0.0.105-for-2.4.27 broken?
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SoftwareSuspend-Help <softwaresuspend-help@berlios.de>
In-Reply-To: <chl1qr$1ic$1@p3EE060A9.dip0.t-ipconnect.de>
References: <chl1qr$1ic$1@p3EE060A9.dip0.t-ipconnect.de>
Content-Type: text/plain
Message-Id: <1094596044.3001.12.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 08 Sep 2004 08:27:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-09-08 at 05:23, Andreas Hartmann wrote:
> Hello!

First, I should mention that your posting should really go to one of the
mailing lists on Berlios. I'll cc there now :>

> I applied to a vanilla kernel the following patches from
> software-suspend-2.0.0.105-for-2.4.27:
> 
> 10-preempt
> 10-preempt-log
> 20-software-suspend-linux-2.4.27-rev2-whole
> 30-software-suspend-core-2.0.0.104-whole
> 31-software-suspend-core-2.0.0.105-incremental
> 
> First of all:
> After booting this kernel, I can't see any /proc/swsusp entries, but
> /proc/sys/kernel/swsusp exists.

Yes, that's because recent versions use /proc/software_suspend/ instead.

> When trying to hibernate, suspension is canceled, because there wouldn't
> be enough space in the swap device - which is obviously wrong. I've got
> 512 MB RAM and the swap partition has the same size. When trying to
> hibernate, RAM is used half and the swap partition isn't used at all.

Hmm. It should work, and I'm using 2.4.27 on my laptop. That said, I'm
working on some improvements to suspend's memory management. 106 should
be out shortly.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

