Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275611AbRJAVz4>; Mon, 1 Oct 2001 17:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275615AbRJAVzf>; Mon, 1 Oct 2001 17:55:35 -0400
Received: from post.aecom.yu.edu ([129.98.1.4]:23445 "EHLO post.aecom.yu.edu")
	by vger.kernel.org with ESMTP id <S275611AbRJAVzX>;
	Mon, 1 Oct 2001 17:55:23 -0400
Mime-Version: 1.0
Message-Id: <a05100301b7de96300568@[129.98.91.150]>
In-Reply-To: <20011001214200.A23514@caldera.de>
In-Reply-To: <a05100310b7de4e632992@[129.98.91.150]>
 <20011001214200.A23514@caldera.de>
Date: Mon, 1 Oct 2001 17:55:49 -0400
To: Christoph Hellwig <hch@ns.caldera.de>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: [HANG] Checking root filesystem and then...
Cc: linux-kernel@vger.kernel.org, vkuznet@fnal.gov
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Oct 01, 2001 at 03:39:36PM -0400, Maurice Volaski wrote:
>>  Running on a Netfinity x340 box (single PIII, ServRAID card and
>>  Adaptec 29160LP card, boot disk is ext2 and is attached to the
>>  ServRAID card), a stock 2.4.10 kernel gets to the point of "Checking
>>  root filesystem" and the system simply stops dead in its tracks.
>>
>>  It stops at the line initlog -c "fsck -T -a $fsckoptions /" If I
>>  remove the "initlog", it still stops. If I remove the "fsck", it
>>  stops at the next line (mount -n -o remount, rw /)!
>>
>>  I have systematically tried a number of different kernels and have
>>  discovered that
>>
>>  2.4.10-pre5 works
>>  2.4.10-pre6 hangs
>>
>>  2.4.9-ac7 works
>>  2.4.9-ac8 hangs
>
>2.4.9-ac17+ should work again, could you test it please?
>

Yes, it works!

-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
