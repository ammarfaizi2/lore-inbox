Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282092AbRLLUv1>; Wed, 12 Dec 2001 15:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282129AbRLLUvR>; Wed, 12 Dec 2001 15:51:17 -0500
Received: from mail.igrin.co.nz ([202.49.244.12]:27148 "EHLO mail.igrin.co.nz")
	by vger.kernel.org with ESMTP id <S282092AbRLLUvG>;
	Wed, 12 Dec 2001 15:51:06 -0500
Message-Id: <3.0.6.32.20011213094953.01077600@mail.igrin.co.nz>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Thu, 13 Dec 2001 09:49:53 +1300
To: Jan Kara <jack@suse.cz>
From: Simon Byrnand <simon@igrin.co.nz>
Subject: Re: Bug in disk Quota's on 2.2.19 (and maybe other kernels) ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011212154515.C16674@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3.0.6.32.20011211164149.00b7ba20@mail.igrin.co.nz>
 <3.0.6.32.20011211164149.00b7ba20@mail.igrin.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:45 PM 12/12/01 +0100, Jan Kara wrote:

>  Hi,
>
>> I've just started using Disk Quotas with Redhat 6.2, and 2.2.19 kernel,
ext2.
>> 
>> Everything is working ok except I notice an anomoly - if I have an apache
>> log file (which is kept open while apache is running) which is owned by a
>> normal user account, and I chown it to root, the quotas are not updated to
>> reflect the fact that the user who used to own the file should have less
>> space "used" from their quota. There should be a decrease in the amount of
>> space used in their quota by the size of the file.

>  I tried to reproduce the problem at home but I didn't succeed. Are you
>able to reproduce the problem? Is the problem occuring just for that
>log file or chowning any file doesn't work?

I'll do some more testing and try to isolate when it happens, but I
probably wont get time until at least tommorow...

Regards,
Simon


