Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTKPTvb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 14:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTKPTvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 14:51:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1457 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262106AbTKPTva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 14:51:30 -0500
Message-ID: <3FB7D52A.7020402@pobox.com>
Date: Sun, 16 Nov 2003 14:51:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
References: <200311162009.52813.arvidjaar@mail.ru>
In-Reply-To: <200311162009.52813.arvidjaar@mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> Apparently not:
> 
> {pts/1}% head -2 /proc/mounts
> rootfs / rootfs rw 0 0
> /dev/root / reiserfs rw 0 0
> 
> at least it is still mounted. Is there any way to free it?


rootfs is always present.  It's the root, as the name implies :)

	Jeff



