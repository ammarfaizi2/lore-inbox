Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272764AbTHPLVR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 07:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272821AbTHPLVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 07:21:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29600 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272764AbTHPLVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 07:21:16 -0400
Message-ID: <3F3E139E.2020300@pobox.com>
Date: Sat, 16 Aug 2003 07:21:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Behdad Esfahbod <behdad@bamdad.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: devfs oops on module missing
References: <Pine.LNX.4.44.0308161011570.30273-100000@gilas.bamdad.org>
In-Reply-To: <Pine.LNX.4.44.0308161011570.30273-100000@gilas.bamdad.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Behdad Esfahbod wrote:
> Hi,
> 
> With 2.6.0-test3 and 2.6.0-test2, devfs mounting at boot time, 
> devfsd 1.3.25 installed, no floppy drive, so floppy,ko would 
> reject to load.  On boot time got this:
> 
> modprobe: FATAL: Error inserting floppy 
> (/lib/modules/2.6.0-test3/kernel/drivers/block/floppy.ko): No such device
> 
> devfs_put(f7498780): poisoned pointer


hmm, isn't it time we deprecated devfs?

	Jeff



