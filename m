Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTLXTFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 14:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTLXTFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 14:05:31 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:3408 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263803AbTLXTFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 14:05:24 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: linux-kernel@vger.kernel.org
Subject: Re: [NEW FEATURE]Partitions on loop device for 2.6
Date: Wed, 24 Dec 2003 20:04:14 +0100
User-Agent: KMail/1.5
References: <200312241341.23523.blaisorblade_spam@yahoo.it>
In-Reply-To: <200312241341.23523.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312242004.14750.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Answering to Sean Estabrooks:

1st, I asked to be CC'ed on replies, as I'm not subscribed. In fact I'm sorry 
your mail is not properly quoted, as I did this by hand.

On Wed, 24 Dec 2003 18:20:22 +0100
BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
>> NEED:
>> I have the need to loop mount files containing not plain filesystems,
>> but whole disk images.
>> 
>
>What does your proposed feature
Note that I propose also beta-code(not actually ready due to the BLKRRPART 
problem).
> add to the kernel that can't be
>accomplished with the "losetup" command and its offset parameter?
If you read my mail, I already noted the existance of the offset parameter, 
but do you prefer:
1) to run fdisk, shoot some commands and get the offset and then put that 
offset into losetup or mount, saving some code but losing a lot of 
time(remember computers are all about saving time for humans); this could 
actually be scripted, and if you post a script to do this I could even use 
it.
2) or use existing code in the kernel to automate all this, with minimal 
intrusiveness?
I know that moving things to userspace is useful if it helps reduce kernel 
bloating(and this patch will not bloat anything); yet we could move partition 
handling to the userspace by adding an offset param for general mounts, but 
this doesn't happen.
However for this it's matter of taste.

Good bye and merry Christmas!
-- 
Paolo Giarrusso, aka Blaisorblade

