Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVE2USA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVE2USA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 16:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVE2USA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 16:18:00 -0400
Received: from mail.dvmed.net ([216.237.124.58]:56807 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261428AbVE2UR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 16:17:57 -0400
Message-ID: <429A236D.8030307@pobox.com>
Date: Sun, 29 May 2005 16:17:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Thonke <iogl64nx@gmail.com>
CC: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de> <4299BD23.6010004@gmail.com> <20050529190259.GA29770@suse.de> <429A2238.8010604@gmail.com>
In-Reply-To: <429A2238.8010604@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:
> Well the subjective feeling is great through! What I noticed is a
> improvement on rsync (goes slighty faster drive to drive).
> The noise decrease now it only make noise on very heavy IO reads and writes.


It might be as simple as...  NCQ means the drive is doing more work. 
More work means more noise.

	Jeff


