Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265787AbUFWQGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265787AbUFWQGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265790AbUFWQEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:04:22 -0400
Received: from www.nute.net ([66.221.212.1]:32908 "EHLO mail.nute.net")
	by vger.kernel.org with ESMTP id S265930AbUFWQEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:04:05 -0400
Date: Wed, 23 Jun 2004 16:04:03 +0000
From: Mikael Bouillot <xaajimri@corbac.com>
To: linux-kernel@vger.kernel.org
Cc: Martin Zwickel <martin.zwickel@technotrend.de>
Subject: Re: Forcedeth driver bug
Message-ID: <20040623160403.GA11348@mail.nute.net>
References: <20040623142936.GA10440@mail.nute.net> <20040623164627.3234bc29@phoebee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623164627.3234bc29@phoebee>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you really know that the driver don't get the stuck packet. Or is it possible
> that the kernels network stack does the fault?

  No, I'm not sure it's the driver's fault. I have this problem since I
switched from nvnet to forcedeth and from 2.4.24 to 2.6.7. But I suspect
this is the drivers fault because:

* I have tried to reproduce it on another 2.6.7 machine (with a
  different driver) and failed.
* Such an important bug in the network stack would hardly go unnoticed.
* The forcedeth driver is still new and somewhat untested :-)


> I'm asking because I have a similar problem with udp and kernel 2.6.7-rc2-mm2.
> My sendto gets stuck sometimes and only continues if the kernel handles another
> network packet.
> 
> But maybe my problem is a totally different one.

  In my case, it's the incoming packets that get stuck. Outgoing packets
work just fine. But then again, I'm not sure without running further
tests. I sent my message to the list mainly to know if this was a well
know bug.

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!
