Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbUA2J6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 04:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbUA2J6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 04:58:55 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:51223 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S264506AbUA2J6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 04:58:54 -0500
Message-ID: <4018D95C.9000409@blueyonder.co.uk>
Date: Thu, 29 Jan 2004 09:58:52 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040118
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1 breaks Cisco VPN client 4.0.3.B
References: <40134BCB.5010803@blueyonder.co.uk>
In-Reply-To: <40134BCB.5010803@blueyonder.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2004 09:59:15.0252 (UTC) FILETIME=[8D830F40:01C3E64E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce wrote:
> 
> Alessandro Suardi wrote:
>  > I know cisco_ipsec is a binary module, but since 4.0.3.B works on
>  > any 2.4 and 2.6.{0,1} kernels I thought I'd report this...
>  >
>  > On starting the VPN connection 'cvpnd' goes in D state, running
>  > ps axlw shows it's stuck in __down.
>  >
>  > Oh, and reboot obviously hangs. I can Alt-SysRq Sync and Umount
>  > but I can't reboot - atkbd.c reports too many keys pressed. Eh ?
>  > Funny, it's three keys just as in the S and U case. It doesn't
>  > seem to like the 'B' letter. I can 'O'ff it though.
>  >
>  > If any kind soul is interested in digging further in this, I'm
>  > as usual available to try stuff out.
> 
> I am seeing the problem with 2.6.2-rc1-mm2. I didn't check cvpnd before 
> I started vpnclient, but both are in D state. Other than that everything 
> is funtional, i.e no lockup and I can do a normal shutdown/reboot. 
> Likewise it works with 2.4.25-pre6. My last look at the Cisco site 
> didn't mention support for 2.6. but it compiles whereas 4.0.1.A didn't. 
> I may go back to the latest 2.6.1 kernel and see if that works. The 
> latest release doc for 4.0.3 dated Dec.2003 still says it doesn't work 
> with kernel 2.5, it may be the document hasn't been updated.
> Regards
> Sid.
> 
> 
> ------------------------------------------------------------------------

I haven't yet got around to trying with 2.6.2-rc2-mm1. I wonder if 
anyone else has tried lately.
Regards
Sid.


-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.
