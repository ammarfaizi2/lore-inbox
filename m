Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268944AbUJKN30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268944AbUJKN30 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUJKN30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:29:26 -0400
Received: from mail.broadpark.no ([217.13.4.2]:15831 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S268944AbUJKN3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:29:24 -0400
Message-ID: <416A8B6C.30206@linux-user.net>
Date: Mon, 11 Oct 2004 15:32:28 +0200
From: Daniel Andersen <anddan@linux-user.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tejun Heo <tj@home-tj.org>, netdev@oss.sgi.com
Subject: Re: via-velocity heads up (was (Re: Linux 2.6.9-rc4 - pls test (and
 no more patches))
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org> <20041011072307.GA18577@electric-eye.fr.zoreil.com>
In-Reply-To: <20041011072307.GA18577@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Linus Torvalds <torvalds@osdl.org> :
> [...]
> 
>>Summary of changes from v2.6.9-rc3 to v2.6.9-rc4
>>============================================
> 
> [...]
> 
>>Fran?ois Romieu:
>>  o via-velocity: properly manage the count of adapters
>>  o via-velocity: removal of unused velocity_info.xmit_lock
>>  o via-velocity: velocity_give_rx_desc() removal
>>  o via-velocity: received ring wrong index and missing barriers
>>  o via-velocity: early invocation of init_cam_filter()
>>  o via-velocity: removal of incomplete endianness handling
>>  o via-velocity: wrong buffer offset in velocity_init_td_ring()
>>  o via-velocity: comment fixes
> 
> 
> The attribution is a bit misleading as Tejun Heo <tj@home-tj.org>
> did the real work (he appears in the logs though).
> 
> People should really, really, test this code if they have been
> experiencing issues with the driver lately.
> 
> Test reports welcome here or on netdev@oss.sgi.com.
> 

I'm finally able to successfully use my On board VT6122 10/100/1000 Mb 
PCI Ethernet Controller on my Abit KV8-Pro. I have not found any 
problems with the via-velocity driver yet. Great work! :)

Daniel Andersen

--
