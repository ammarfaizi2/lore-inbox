Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965258AbVKIH1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbVKIH1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 02:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbVKIH1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 02:27:46 -0500
Received: from mail.dvmed.net ([216.237.124.58]:3296 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965258AbVKIH1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 02:27:45 -0500
Message-ID: <4371A4ED.9020800@pobox.com>
Date: Wed, 09 Nov 2005 02:27:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: userspace block driver?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anybody put any thought towards how a userspace block driver would work?

Consider a block device implemented via an SSL network connection.  I 
don't want to put SSL in the kernel, which means the only other 
alternative is to pass data to/from a userspace daemon.

Anybody have any favorite methods?  [similar to] mmap'd packet socket? 
ramfs?

TIA,

	Jeff





