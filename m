Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbUKJVUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUKJVUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUKJVUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:20:47 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:64131 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262050AbUKJVUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:20:20 -0500
Message-ID: <41927F12.4090609@tmr.com>
Date: Wed, 10 Nov 2004 15:50:26 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] change Kconfig entry for RAMFS
References: <Pine.LNX.4.60.0411060027560.3255@alpha.polcom.net><Pine.LNX.4.60.0411060027560.3255@alpha.polcom.net> <20041109232402.GA8040@waste.org>
In-Reply-To: <20041109232402.GA8040@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Sat, Nov 06, 2004 at 12:44:14AM +0100, Grzegorz Kulewski wrote:
> 
>>>So at the very least you'd need to make the Kconfig understand the
>>>dependency on ramfs.
>>
>>Should I add dependency to tmpfs on ramfs when building for embedded? Or 
>>should I introduce new config option to stop registering ramfs as a 
>>mountable filesystem?
> 
> 
> Root is ramfs at early boot time, making it optional is tricky.
> 
Other than not being able to boot the system, would there be any other 
problems? ;-)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

