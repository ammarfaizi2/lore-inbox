Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbWHROyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbWHROyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbWHROx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:53:59 -0400
Received: from sandeen.net ([209.173.210.139]:28987 "EHLO sandeen.net")
	by vger.kernel.org with ESMTP id S1030460AbWHROx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:53:59 -0400
Message-ID: <44E5D485.5090601@sandeen.net>
Date: Fri, 18 Aug 2006 09:53:57 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: sho@tnes.nec.co.jp
Cc: esandeen@redhat.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] fix ext3 mounts at 16T
References: <20060818181516sho@rifu.tnes.nec.co.jp>
In-Reply-To: <20060818181516sho@rifu.tnes.nec.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sho@tnes.nec.co.jp wrote:
> Hi,
> 
> I had done the same work for both ext3 and ext2,
> and sent the patches to ext2-devel three months ago.
> If you need, you can get them from the following URL.

Thank you, I did not know that anyone else had done this work (I guess I should 
have searched...!)

Thanks for the pointer, I will compare my patches to yours.  I guess it can be 
considered an independent review. :)

> I have reviewed your patch and found other place which might
> cause overflow as below.  If group_first_block is the first block of
> the last group, overflow will occur.  This has already been fixed
> in my patch.

I had that patch locally as well, but had not yet sent it out.

Thanks,
-Eric
