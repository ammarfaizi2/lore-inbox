Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUHHPY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUHHPY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 11:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUHHPY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 11:24:57 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:30317 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S265521AbUHHPYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 11:24:55 -0400
Message-ID: <411645B4.7070907@travellingkiwi.com>
Date: Sun, 08 Aug 2004 16:24:36 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide-cs using 100% CPU
References: <fa.j0leddb.okcbor@ifi.uio.no> <fa.goasld9.1q1kb05@ifi.uio.no> <006d01c47cb3$b2e133b0$6401a8c0@northbrook>
In-Reply-To: <006d01c47cb3$b2e133b0$6401a8c0@northbrook>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

>It isn't that the CPU is doing so much work, it's mostly waiting. However
>  
>

That was my point... While waiting, shouldn't the CPU be off doing 
something else? Like giving X some attention...

>with this type of PIO access, the CPU must do all the reads/writes from the
>buffer and while doing this the CPU is blocked and cannot do anything else.
>
>  
>

Or is the CF requirements such that it's spending it's time doing the 
actual reads & writes from the buffer, and it's the hardware inserting 
wait-states when it's being accessed?


