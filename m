Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWBANQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWBANQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWBANQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:16:04 -0500
Received: from 1-1-3-46a.gml.gbg.bostream.se ([82.182.110.161]:54498 "EHLO
	kotiaho.net") by vger.kernel.org with ESMTP id S964957AbWBANQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:16:02 -0500
Date: Wed, 1 Feb 2006 14:15:21 +0100 (CET)
From: "J.O. Aho" <trizt@iname.com>
X-X-Sender: trizt@lai.local.lan
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel maillist <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
In-Reply-To: <20051211.210752.83944980.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0602011406260.27149@lai.local.lan>
References: <Pine.LNX.4.64.0512102350310.4739@lai.local.lan>
 <20051210.150034.67577008.davem@davemloft.net> <Pine.LNX.4.64.0512110020050.4809@lai.local.lan>
 <20051211.210752.83944980.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Dec 2005, David S. Miller wrote:

> I strongly believe your kernel is being miscompiled by whatever
> gcc is being used to build your kernels.

After a bit posting at comp.sys.sun.hardware I found a person with an 
Ultra60 using Creator3D (UPA) too on it, he had a working X. He did run 
kernel 2.6.8, so today I did install 2.6.8.1 (vanilla) and tested Xorg 
and it worked as well as it does under 2.4.x.

I guess there has been some bad change in the sparc kernel code somewhere 
between 2.6.8.1 and 2.6.13. I can say that 2.6.15.1 still "crashes" the 
kernel. I don't know if there has been any discussion if it's the small 
amount of UPA relatad code that causes the problem or not, but I think 
it's plausible that the UPA code has been "damaged" in the later versions 
of the kernel.


-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
