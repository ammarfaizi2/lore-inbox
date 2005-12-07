Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbVLGVWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbVLGVWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbVLGVWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:22:48 -0500
Received: from 1-1-3-46a.gml.gbg.bostream.se ([82.182.110.161]:44726 "EHLO
	kotiaho.net") by vger.kernel.org with ESMTP id S1751785AbVLGVWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:22:47 -0500
Date: Wed, 7 Dec 2005 22:22:42 +0100 (CET)
From: "J.O. Aho" <trizt@iname.com>
X-X-Sender: trizt@lai.local.lan
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel maillist <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
In-Reply-To: <20051207.123458.26771065.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0512072217580.24376@lai.local.lan>
References: <Pine.LNX.4.64.0512061658190.14952@lai.local.lan>
 <20051206.152316.82233251.davem@davemloft.net>
 <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
 <20051207.123458.26771065.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, David S. Miller wrote:

> From: "J.O. Aho" <trizt@iname.com>
> Date: Wed, 7 Dec 2005 12:05:43 +0100 (CET)
>
>> When running in plain console (without trying to run X) everything works
>> fine (just telling that so I won't get people to ask if ps segfaults in
>> other cases or claims that my init is broke and so on).
>
> Is the Xorg.conf setup to use the "ati" driver?  You can't use
> "fbdev" or similar, that will in fact hang the machine in a
> manner similar to how you describe.

I'm using the sunffb driver, as I wish to get the output from my creator3d 
card, so that I can see something displayed as the monitor requiers a 13W3 
connector. So I assume from your reply that framebuffer isn't working in 
kernel 2.6 for sparc, but for other archs like ppc?

-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
