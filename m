Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbTHQNBz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269736AbTHQNBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:01:55 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:55517 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S268751AbTHQNBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:01:54 -0400
Message-ID: <3F3F7E67.2040506@t-online.de>
Date: Sun, 17 Aug 2003 15:08:55 +0200
From: Dominik.Strasser@t-online.de (Dominik Strasser)
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi.h uses "u8" which isn't defined.
References: <3F3F782C.2030902@t-online.de> <20030817134633.A7881@infradead.org>
In-Reply-To: <20030817134633.A7881@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: SgTlkqZ1re86M9MjAeUJ64sRrWvcXyaXZWG2AJGBTHFbaWWGLUtZgJ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Aug 17, 2003 at 02:42:20PM +0200, Dominik Strasser wrote:
> 
>>scsi.h uses "u8" which doesn't seem to be defined.
>>Better use u_char.
> 
> 
> It's defined in <linux/types.h> as is u_char.  But we generally prefer
> explicitly sized types in Linux - and u_char is a BSDism, the right
> not explicitly sized type would be unsigned char.

I am sorry, in 2.6.0-test3 (which I should have mentioned), there is no 
u8 in liux/types.h. Just a __u8.
Nevertheless there is a mixture in scsi.h, some lines above, u_char is 
used. This is why I chose to use it.

Dominik


