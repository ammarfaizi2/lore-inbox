Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWAKAPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWAKAPd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWAKAPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:15:33 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:504 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932354AbWAKAPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:15:32 -0500
Date: Wed, 11 Jan 2006 00:15:28 +0000 (GMT)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 64-bit vs 32-bit userspace/kernel benchmark? Was: Athlon 64 X2
 cpuinfo oddities
In-Reply-To: <43C417A5.6070104@mnsu.edu>
Message-ID: <Pine.LNX.4.63.0601102321040.14407@deepthought.mydomain>
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com> 
 <p73r77gx36u.fsf@verdi.suse.de>  <9a8748490601091812x24aefae3oc0c6750c5321c3ab@mail.gmail.com>
  <200601100336.31677.ak@suse.de> <9a8748490601100129h2ce343f5kc9bc22885f01831a@mail.gmail.com>
 <43C417A5.6070104@mnsu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-78232903-1136938528=:14407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-78232903-1136938528=:14407
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 10 Jan 2006, Jeffrey Hundstad wrote:

>
> Has anyone done any actual benchmark tests that show 64-bit vs 32-bit 
> environments/distributions with Athlon64 processors.  If so, I love to see 
> the results.  I too elected to stick with 32-bit, using the same 
> reasoning/guessing above.
>
  Some months ago, on a 2GHz San Diego (4000+) I ran some tests using 
linuxfromscratch with 2.6.11.11, 1 GB PC3200, ext3, 5 runs of each

(a) specific oggenc and photo manipulations in parallel

64-bit kernel, total time 246.053 to 257.601 sec, avg 250.022, std dev 
4.62415
32-bit kernel, total time 247.572 to 258.963 sec, avg 252.405, std dev 
4.22909
pure64,        total time 172.942 to 177.532 sec, avg 174.582, std dev 
1.90047

  At that time, I hadn't built multilib.

Ken
-- 
  das eine Mal als Tragödie, das andere Mal als Farce

---1463809536-78232903-1136938528=:14407--
