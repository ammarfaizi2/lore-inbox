Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbWGaVpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWGaVpB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWGaVpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:45:01 -0400
Received: from smtp.ono.com ([62.42.230.12]:54002 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S1030472AbWGaVpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:45:00 -0400
Date: Mon, 31 Jul 2006 23:44:58 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.18-rc1-mm2] libata: DMA speed too slow for cdrecord
Message-ID: <20060731234458.7f1d5cad@werewolf.auna.net>
In-Reply-To: <1154359666.7230.36.camel@localhost.localdomain>
References: <20060729235431.322ea6d3@werewolf.auna.net>
	<1154344141.7230.18.camel@localhost.localdomain>
	<20060731165122.08ac464e@werewolf.auna.net>
	<1154359666.7230.36.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 16:27:46 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Llu, 2006-07-31 am 16:51 +0200, ysgrifennodd J.A. Magallón:
> > What file is the new speed selection code in ? libata-core.c, ata-piix.c ?
> > I can try to get the old kernel patched...
> 
> libata-core
> 
> > Or is there any patch available ?
> 
> Copy the working ata-piix.c from -mm1 into the -mm2 tree and try that,
> it should do the trick for you.
> 

Just to complete the history in the mailing list, problem solved.
Future readers, see this thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115408717700150&w=2

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam05 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #3 SMP PREEMPT
