Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVJCSkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVJCSkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVJCSkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:40:45 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:6149 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932555AbVJCSkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:40:43 -0400
Message-ID: <43417B3E.4020807@tmr.com>
Date: Mon, 03 Oct 2005 14:41:02 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Kesterson <robertk@robertk.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.13] drivers/ide: Enable basic VIA VT6410 IDE functionality
References: <op.sxg2dxd5wc4mme@new.robertk.com>
In-Reply-To: <op.sxg2dxd5wc4mme@new.robertk.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kesterson wrote:
> This patch enables plain IDE functionality on the VIA VT6410 IDE controller
> (such as used on the Asus P4P800 Deluxe motherboard).  This is not a RAID
> driver, but you can use Linux's software RAID once the drives are visible.
> I did not write the original version of this patch, which I found on the
> internet back in the days of kernel 2.6.2.  I have been unable to identify
> the original author to give him/her proper credit.  I have been maintaining
> and updating this patch since then and have released several updates which
> have been successfully used by others who have downloaded it from my
> website.
> 
> It seems appropriate that this minimal functionality should be in the
> mainstream kernel.

After using this patch (it works), it comes to me that the 2.4 version 
was in a separate driver, so I can control my order of controller 
recognition. Just having access to the devices is useful, but it would 
be more useful in the module version.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
