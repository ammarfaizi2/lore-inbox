Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265229AbUFHPxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUFHPxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUFHPxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:53:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35285 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265229AbUFHPxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:53:04 -0400
Message-ID: <40C5E0CD.8060107@pobox.com>
Date: Tue, 08 Jun 2004 11:52:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Andrew Morton <akpm@osdl.org>, Linus <torvalds@osdl.org>,
       linuxppc64-dev@lists.linuxppc.org, LKML <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] PPC64 iSeries virtual DVD-RAM
References: <20040608224646.529860f4.sfr@canb.auug.org.au>
In-Reply-To: <20040608224646.529860f4.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Hi Andrew, Linus,
> 
> This patch enables access to DVD-RAM devices on iSeries boxes.  It also
> adds some more device ids for some newer DVD-RAM drives.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Has Jens, our cdrom maintainer, reviewed this?

I'm a bit curious why you handle GPCMD_READ_DISC_INFO and not let the 
underlying device handle it, for example.

	Jeff


