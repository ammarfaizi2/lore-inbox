Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVLFQKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVLFQKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 11:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVLFQKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 11:10:34 -0500
Received: from 1-1-3-46a.gml.gbg.bostream.se ([82.182.110.161]:9349 "EHLO
	kotiaho.net") by vger.kernel.org with ESMTP id S932109AbVLFQKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 11:10:33 -0500
Date: Tue, 6 Dec 2005 17:10:07 +0100 (CET)
From: "J.O. Aho" <trizt@iname.com>
X-X-Sender: trizt@lai.local.lan
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel maillist <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
In-Reply-To: <20051205.181732.34234732.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0512061658190.14952@lai.local.lan>
References: <Pine.LNX.4.64.0512060257160.27930@lai.local.lan>
 <20051205.181732.34234732.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005, David S. Miller wrote:

> From: "J.O. Aho" <trizt@iname.com>
> Date: Tue, 6 Dec 2005 03:04:11 +0100 (CET)
>
>> The dmesg entry comes from 2.6.15-rc2, but is kind of the same, expect not
>> all versions has the ugly and annoying face.
>
> 1) Lots of problems have been fixed that trigger that bug message,
>   please give 2.6.15-rc5 a spin.

Have been trying 2.6.x kernels today, including the 2.6.15-rc5 and it's 
still there.

> 2) You didn't give what the failure mode is for kernels such
>   as 2.6.14.2, which should work, and certainly don't print out
>   that bug message

It's the same as for 2.6.13 and 2.6.15rc, did build a 2.6.14.3 as had 
removed the 14.2 when I started to use 15rc.


> 3) Finally, this discussion belongs on sparclinux@vger.kernel.org (CC'd),
>   not linux-kernel.

The kernel output said "linux-kernel", which is why I sent the the mail to 
"linux-kernel", maybe the displayed address should have the arch depending 
address instead of the general?


More data:

Xorg: 6.8.2 (xaa patched sunffb driver)
Distro: Gentoo (64bits kernel, 32bit user)
Machine: Ultra 10

xorg.conf: 
http://dev.gentoo.org/~fmccor/docs/xorg/xorg.conf/xorg.conf.html
(see the one for kernel 2.6)

Xorg.0.log: http://www.kotiaho.net/~trizt/tmpimg/sparc_xorg.log

dmesg output from kernels 2.6.13 -> 2.6.15-rc5: 
http://www.kotiaho.net/~trizt/tmpimg/sparc_xorg.dmesg


As earlier said, the Xorg 6.8.2 works fine with the 2.4 specific 
xorg.conf (see on the xorg.conf link) and with a 2.4 kernel.


-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
