Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWCEQOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWCEQOf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 11:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWCEQOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 11:14:35 -0500
Received: from main.gmane.org ([80.91.229.2]:2988 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932110AbWCEQOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 11:14:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Date: Sun, 05 Mar 2006 17:14:19 +0100
Message-ID: <pan.2006.03.05.16.14.19.327190@free.fr>
References: <Pine.LNX.4.61.0603041945520.29991@yvahk01.tjqt.qr> <20060304.134144.122314124.davem@davemloft.net> <200603041705.41990.gene.heskett@verizon.net> <20060304.141643.04633220.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Le Sat, 04 Mar 2006 14:16:43 -0800, David S. Miller a écrit :

> From: Gene Heskett <gene.heskett@verizon.net>
> Date: Sat, 04 Mar 2006 17:05:41 -0500
> 
>> On Saturday 04 March 2006 16:41, David S. Miller wrote:
>> >From: Jan Engelhardt <jengelh@linux01.gwdg.de>
>> >Date: Sat, 4 Mar 2006 19:46:22 +0100 (MET)
>> >
>> >> Does this buy the normal standard desktop user anything?
>> >
>> >Absolutely, it optimizes end-node performance.
>> 
>> Is this quantifiable?, and does it only apply to Intel?
> 
> It applies to whoever has a DMA engine in their computer.
> 
But we need a special driver ?
The IOAT driver from intel seems to expect a pci device (0x8086 0x1a38)
and the common x86 computer have their dma in lpc/isa bridge.


Matthieu

