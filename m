Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263179AbTCLNvi>; Wed, 12 Mar 2003 08:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263182AbTCLNvi>; Wed, 12 Mar 2003 08:51:38 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:24843 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263179AbTCLNvh>; Wed, 12 Mar 2003 08:51:37 -0500
Message-Id: <200303121353.h2CDrhu30117@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "David Shirley" <dave@cs.curtin.edu.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Help, eth0: transmit timed out!
Date: Wed, 12 Mar 2003 15:50:48 +0200
X-Mailer: KMail [version 1.3.2]
References: <041b01c2e86a$870822f0$64070786@synack> <200303121340.h2CDe3u30029@Port.imtp.ilyichevsk.odessa.ua> <000a01c2e89e$e9ab9c50$2400a8c0@compaq3>
In-Reply-To: <000a01c2e89e$e9ab9c50$2400a8c0@compaq3>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 March 2003 15:54, David Shirley wrote:
> Its strange we have another machine, exact same setup,
> hardware/software and it doesn't have any problems.

Did you try to swap some hardware? NIC would be the first
to swap.

> The other thing is that sometimes the machine freezes totally,
> and othertimes it comes back after 30 secs??

If it's a driver problem, anything is possible.

> FYI: Its not a modular kernel, but ill try the printk thing.

Modular one will be far easier (faster) to play with.
You just unload the module, recompile and reload.
No reboot cycles.
--
vda
