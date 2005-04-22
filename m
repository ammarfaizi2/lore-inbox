Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVDYQt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVDYQt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVDYQrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:47:49 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:27529 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262670AbVDYQrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:47:09 -0400
Message-ID: <426945CC.6040100@tmr.com>
Date: Fri, 22 Apr 2005 14:43:24 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
CC: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: Crash when unmounting NFS/TCP with -f
References: <4268EEC9.8010305@ens-lyon.org>
In-Reply-To: <4268EEC9.8010305@ens-lyon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:
> Hi Trond,
> 
> I'm using NFS (v2) over TCP (in a SSH tunnel).
> Each time the SSH dies before a umount NFS, I have to umount -f
> and I get a crash (only sysrq works).
> Actually, the crash occurs a few seconds after umount -f.
> 
> It seems that killing SSH by hand does _not_ lead to crash.
> But a long network failure does.
> I remember seeing this bug several times with all stable releases
> from 2.6.7 to 2.6.11. I didn't try with earlier versions.
> 
> I didn't see anything in the logs (after reboot). But I can't be sure
> there was nothing in dmesg since I didn't get a chance to chvt 1 and
> see console messages before rebooting (with sysrq).
> 
> Do you have any idea how to debug this ?

No clue, but a question: is this a hard or soft mount? Could you post 
your ssh and mount commands, munged as needed for security? That might 
give someone a clue.

I did this "back when" but I don't recall having a problem with it.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

