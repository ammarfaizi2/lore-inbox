Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVGZP44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVGZP44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVGZP4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:56:38 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54969 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261923AbVGZPzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:55:55 -0400
Message-ID: <42E65D06.3050405@pobox.com>
Date: Tue, 26 Jul 2005 11:55:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master 07/10] blk: add FUA support to
 libata
References: <20050726154457.38D60C67@htj.dyndns.org> <20050726154457.4305D013@htj.dyndns.org>
In-Reply-To: <20050726154457.4305D013@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> 07_blk_libata-add-fua-support.patch
> 
> 	Add FUA support to libata.

NAK -- doesn't appear to take into account that read/write(6) don't 
support FUA.

Correct me if I'm wrong.

Otherwise, looks OK.


