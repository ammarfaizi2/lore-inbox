Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266523AbUFQO6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266523AbUFQO6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUFQO6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:58:09 -0400
Received: from meetpoint.leesburg-geeks.org ([66.63.28.250]:60937 "EHLO
	meetpoint.home") by vger.kernel.org with ESMTP id S266523AbUFQO4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:56:25 -0400
Message-ID: <40D1B110.7020409@leesburg-geeks.org>
Date: Thu, 17 Jun 2004 10:56:16 -0400
From: Ken Ryan <linuxryan@leesburg-geeks.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: pla@morecom.no
Subject: Re: mode data=journal in ext3. Is it safe to use?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > Data integrity is much more important for us than speed.
> > > 
> > 
> > 
> > You might want to consider ReiserFS or one of the others which were 
> > designed with journaling in mind.  And I hope you're using RAID1 or RAID5.
> 
> We are using ext3 on a compact flash disk in an embedded device. So we
> are not using RAID systems.

[I'm not subscribed, hopefully this threads]

Um, is this a new application or have you done this before?

It's my understanding that very few (or no) CF devices do wear-levelling internally.
Using a journal, especially a true data journal, seems like *the* way to wear out your
flash as quickly as possible.

If you've had success using ext2 in read/write mode on flash/CF in a shipping product,
I for one would like to know more details!

		ken



