Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTGFUTY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 16:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTGFUTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 16:19:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64131 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263398AbTGFUTX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 16:19:23 -0400
Message-ID: <3F08879D.4070300@pobox.com>
Date: Sun, 06 Jul 2003 16:33:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Clements <Paul.Clements@SteelEye.com>
CC: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHES 2.5.74-mm2] misc. nbd cleanups/fixes
References: <3F088277.3EB39CE2@SteelEye.com>
In-Reply-To: <3F088277.3EB39CE2@SteelEye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:
> The two attached patches are:
> 
> 1) nbd-remove_open_release.diff - remove the unneeded nbd_open and
> nbd_release functions

Please remove the unneeded ->refcnt member as well.


> 2) nbd-block_layer_compat.diff - ensure that nbd and the block layer
> agree about device block sizes and total device sizes

Use set_blocksize, please.

Also, please split up your patches further.  The Linux (Linus?) standard 
is one patch per email...  Also, attachments are discouraged, though not 
a "no no" because of various broken corporate email systems...

	Jeff



