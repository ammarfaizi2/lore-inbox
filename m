Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTEEUdU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbTEEUdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:33:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28873 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261265AbTEEUdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:33:19 -0400
Message-ID: <3EB6CD68.9010506@pobox.com>
Date: Mon, 05 May 2003 16:45:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: viro@parcelfarce.linux.theplanet.co.uk, perex@suse.cz,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unused funcion proc_mknod
References: <20030505190045.A22238@lst.de> <20030505192248.GD10374@parcelfarce.linux.theplanet.co.uk> <20030505213004.B24006@lst.de>
In-Reply-To: <20030505213004.B24006@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Jaroslav, can we just drop that junk or is it still used by userland.
> And if yes how long will it take to get an alsa-libs release out to
> not rely on it?


Not commenting on this issue specifically, but in general, alsa-lib can 
be used to mitigate the effect of kernel changes on userland.

This was a big selling point for ALSA, back when we were trying to 
decide what to do about OSS.

	Jeff



