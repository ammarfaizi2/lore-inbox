Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUBPTLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbUBPTLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:11:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55277 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265820AbUBPTLI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:11:08 -0500
Message-ID: <403115BE.8060602@pobox.com>
Date: Mon, 16 Feb 2004 14:10:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Balaji Calidas <balaji@techsource.com>
Subject: Re: 2.4.24 problems [WAS: Re: IDE DMA problem  [WAS: Re: Getting
 lousy NFS + tar-pipe throughput on 2.4.20]]
References: <402D6262.90301@techsource.com> <200402140154.54307.bzolnier@elka.pw.edu.pl> <4030F94F.1000900@techsource.com> <200402161820.32901.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402161820.32901.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Monday 16 of February 2004 18:09, Timothy Miller wrote:
>>Also, 'root=LABEL=/' doesn't work anymore in grub.conf, and there seems
>>to be no way to enable it.  Is this a RedHat only thing?

> This feature is not present in vanilla kernels.


It's not a kernel feature.

Red Hat's initrd image makes "root=LABEL=/" work.  The user probably 
needs to regen his initrd image...

	Jeff



