Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUIEMBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUIEMBW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUIEMBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:01:21 -0400
Received: from circe.telenet-ops.be ([195.130.132.59]:28806 "EHLO
	circe.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266490AbUIEL7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:59:24 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2 - 'journal block not found' - ext3 on crack?
References: <200409021815.i82IFpLT022145@turing-police.cc.vt.edu>
	<20040903164824.4a3b0ee1.akpm@osdl.org>
From: karl.vogel@seagha.com
Date: Sun, 05 Sep 2004 14:00:23 +0200
In-Reply-To: <20040903164824.4a3b0ee1.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 3 Sep 2004 16:48:24 -0700")
Message-ID: <m37jr9c4dk.fsf@seagha.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Valdis.Kletnieks@vt.edu wrote:
>>
>> I built 2.6.9-rc1-mm2 last night, and I've had this happen on 2 separate file systems today:
>> 
>> Sep  2 12:42:54 turing-police kernel: EXT3-fs error (device dm-6) in start_transaction: Journal has aborted
>
> Probably caused by an I/O error (or data loss) performing metadata reads.
>
>> 3) I'm using ext3-on-LVM, if that matters...
>
> Let me guess: raid5?
>
> We've had a steady stream of heisenbugreports for ext3-on-raid5
> for several years.

For the record, I just got a journal aborted on 2.6.9-rc1-mm3.
I'm also using ext3-on-LVM (no RAID stuff involved).

I'm afraid that I don't have more info.
 
