Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265088AbUFWBkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265088AbUFWBkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 21:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUFWBkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 21:40:16 -0400
Received: from fmr12.intel.com ([134.134.136.15]:30695 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S265088AbUFWBkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 21:40:11 -0400
Message-ID: <40D8DF60.1090803@linux.jf.intel.com>
Date: Tue, 22 Jun 2004 20:39:44 -0500
From: James Ketrenos <jketreno@linux.jf.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Andrew Morton <akpm@osdl.org>, Joshua Kwan <jkwan@rackable.com>,
       linux-kernel@vger.kernel.org
Subject: Re: What happened to linux/802_11.h?
References: <pan.2004.06.21.22.25.18.591967@triplehelix.org> <20040621173827.0403618b.akpm@osdl.org> <20040622004813.GA12334@bougret.hpl.hp.com>
In-Reply-To: <20040622004813.GA12334@bougret.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:

>On Mon, Jun 21, 2004 at 05:38:27PM -0700, Andrew Morton wrote:
>  
>
>>Joshua Kwan <jkwan@rackable.com> wrote:
>>    
>>
>>>The IPW2100 driver
>>>(http://ipw2100.sourceforge.net) uses its definitions and now won't build
>>>against -bk or -mm kernel source.
>>>      
>>>
>>Jean, should we restore 802_11.h, or is there some alternative file which
>>that driver should be using?
>>    
>>
>
>	Well, Jeff explicitely said that we should not care about
>drivers outside the kernel ;-)
>	Seriously, I see three solutions :
>	1) Convert ipw2100 to using drivers/net/wireless/ieee802_11.h,
>extend this header as necessary
>  
>
This is the path I was planning to take when I read about 802_11.h 
possibly going away a while ago.  The file finally going away will just 
raise the priority of that effort a bit :)  Changing the code to use the 
headers in drivers/net/wireless isn't a big task -- I'll put the change 
into the next snapshot of ipw2100.

Thanks,
James
(of ipw2100.sf.net)
