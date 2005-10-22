Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVJVLYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVJVLYz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 07:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVJVLYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 07:24:55 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:25099 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932227AbVJVLYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 07:24:54 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXPERIMENT,RFC] FAT: Add "flush" option for hotplug devices
References: <871x2gf8f5.fsf@devron.myhome.or.jp>
	<20051022101552.GA2403@infradead.org>
	<87hdb9de44.fsf@devron.myhome.or.jp>
	<20051022105632.GA3027@infradead.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 22 Oct 2005 20:24:45 +0900
In-Reply-To: <20051022105632.GA3027@infradead.org> (Christoph Hellwig's message of "Sat, 22 Oct 2005 11:56:32 +0100")
Message-ID: <87wtk5bxqa.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>> Many filesystems does
>> 
>> 	filemap_fdatawrite(mapping);
>> 	filemap_fdatawait(mapping);
>> 
>> Don't you want filemap_write_and_wait()?
>
> Yes, that doesn't fall under the odd exports above.  Care to submit
> a patch to export it (non-_GPL) and convert all users of the above
> pattern to it?

I'll convert it on separated patch. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
