Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266890AbUHIUH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUHIUH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUHIUDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:03:52 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:38826 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S266879AbUHIUAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:00:01 -0400
Message-ID: <4117D88E.6080801@tmr.com>
Date: Mon, 09 Aug 2004 16:03:26 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, sam@ravnborg.org,
       zippel@linux-m68k.org
Subject: Re: [PATCH] save kernel version in .config file
References: <20040803225753.15220897.rddunlap@osdl.org>
In-Reply-To: <20040803225753.15220897.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> (from June/2004 email thread:
> http://marc.theaimsgroup.com/?t=108753573200001&r=1&w=2
> )
> 
> Several people found this useful, none opposed (afaik).
> 
> Saves kernel version in .config file, e.g.:
> 
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.8-rc3
> # Tue Aug  3 22:55:57 2004
> #
> 
> Please merge.
> ---
> 
> Save kernel version info and date when writing .config file.
> Tested with 'make {menuconfig|xconfig|gconfig}'.

I don't see "oldconfig" here, I'm sure there are people who don't care 
because they want to roll every kernel fresh, but for the rest of us...
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
