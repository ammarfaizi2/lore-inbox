Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVI2Tia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVI2Tia (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVI2Ti3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:38:29 -0400
Received: from [67.137.28.189] ([67.137.28.189]:61312 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S964852AbVI2Ti2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:38:28 -0400
Message-ID: <433C3043.6020607@utah-nac.org>
Date: Thu, 29 Sep 2005 12:19:47 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
       Nuno Silva <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
References: <Pine.LNX.4.63.0509290916450.20827@p34> <433C31C8.1030901@vgertech.com> <Pine.LNX.4.63.0509291433340.13272@p34> <433C2A11.9090506@utah-nac.org> <p8goj1h0a6g0oje8uijpi5r2b95l7sj8n4@4ax.com>
In-Reply-To: <p8goj1h0a6g0oje8uijpi5r2b95l7sj8n4@4ax.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:

>On Thu, 29 Sep 2005 11:53:21 -0600, jmerkey <jmerkey@utah-nac.org> wrote:
>
>  
>
>>Someone needs to fix SATA drive ordering in the kernel so it matches 
>>GRUBs ordering, or perhaps GRUB needs fixing. I have run into
>>    
>>
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^
>User-space issue?  Four of the last five drives I buy are SATA, I 
>don't see this problem 'cos I use lilo :o)
>
>Cheers
>
>  
>
Seems to show up on FC2/3/4 installs on Piix motherboards. The drive 
parameters reported for /dev/sda, /dev/sdb are inverted based on the 
BIOS ordering of the SATA devices. It's more a BIOS issues I think. I 
have noted that IDE doesn't change the ordering, but the current Linux 
drivers do.

Jeff
