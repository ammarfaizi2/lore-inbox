Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVCKT35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVCKT35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVCKT00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:26:26 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:9104 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261359AbVCKTXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:23:07 -0500
Message-ID: <4231F14A.2090602@tmr.com>
Date: Fri, 11 Mar 2005 14:28:10 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Krzysztof Halasa <khc@pm.waw.pl>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.2
References: <m3acpa9qta.fsf@defiant.localdomain><m3acpa9qta.fsf@defiant.localdomain> <20050311173808.GZ28536@shell0.pdx.osdl.net>
In-Reply-To: <20050311173808.GZ28536@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Krzysztof Halasa (khc@pm.waw.pl) wrote:
> 
>>Another patch for 2.6.11.x: already in main tree, fixes kernel panic
>>on receive with WAN cards based on Hitachi SCA/SCA-II: N2, C101,
>>PCI200SYN.
>>Also a documentation change fixing user-panic can-t-find-required-software
>>failure (just the same patch as in mainline) :-)
> 
> 
> We are not accepting documentation fixes.  Could you please send just
> the panic fix to stable@kernel.org (cc lkml)?  And add Signed-off-by...

I really think you should not have a hard and fast rule on doc, for the 
case where a fix also makes the mainline doc wrong and someone might do 
something destructive reading the mainline docs and using the fixed 
code. Drivers come to mind.

I am NOT saying this is such a case, I'm just against zero tolerance 
rules when I can see a reasonable case where they don't do what you want.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
