Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269342AbUI3Qrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269342AbUI3Qrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269345AbUI3Qrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:47:53 -0400
Received: from mail.tmr.com ([216.238.38.203]:59654 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269342AbUI3Qru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:47:50 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.9-rc2-mm4
Date: Thu, 30 Sep 2004 12:49:01 -0400
Organization: TMR Associates, Inc
Message-ID: <cjhcte$5na$2@gatekeeper.tmr.com>
References: <20040928103324.GA21050@elte.hu><20040928103324.GA21050@elte.hu> <200409280701.06932.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1096562415 5866 192.168.12.100 (30 Sep 2004 16:40:15 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <200409280701.06932.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Tuesday 28 September 2004 06:33, Ingo Molnar wrote:
> 
>>* Gene Heskett <gene.heskett@verizon.net> wrote:
>>
>>>>what i use is serial logging to another machine. A digital camera
>>>>is fine too, if the problem area is still visible on the screen.
>>>>(Netconsole is useful too for other type of hangs but it's not
>>>>active at such an early stage yet.)
>>>>
>>>>Ingo
>>>
>>>Unforch, I don't have a spare seriel port Ingo.  One is running my
>>>x10
>>
>>fortunately with the patch applied your box works now (so does mine)
>>so the bug appears to be fixed.
> 
> 
> I just built a kernel with that latest stack-fix patch in it too, but 
> haven't rebooted to it yet.  I read that as being moderately 
> important in some cases although I don't think I've encountered that 
> particular case yet.  Was this in fact a good idea for me?
> 
> 
>>early-bootup debugging was never easy, and breakage there doesnt
>>happen all that often. Hopefully this was the last one related to
>>remove-BKL.
>>
>>(If such a early-bootup lockup happens in the future then you sure
>>could temporarily unplug the ups serial connection and use that as
>>the serial console - for the narrow and temporary purpose of
>>debugging that boot-time hang.)
> 
> 
> That would I assume need a null modem cable, and what do I run on the 
> firewall?  Minicom?  Or is there something better that can just grab 
> and log without being interactive?  Its a rh7.3 box with a 2.4.18 era 
> kernel.  I'd update that, but its not broken. :)

I use Kermit, it will do about everything you could ask and gives a 
single interface for serial and network console connections.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
