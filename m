Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbRC0HvN>; Tue, 27 Mar 2001 02:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbRC0HvE>; Tue, 27 Mar 2001 02:51:04 -0500
Received: from jalon.able.es ([212.97.163.2]:55751 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130471AbRC0Huu>;
	Tue, 27 Mar 2001 02:50:50 -0500
Date: Tue, 27 Mar 2001 09:50:02 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Thomas Foerster <puckwork@madz.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: URGENT : System hands on "Freeing unused kernel memory: "
Message-ID: <20010327095002.A25719@werewolf.able.es>
In-Reply-To: <20010327064904Z130600-406+4294@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010327064904Z130600-406+4294@vger.kernel.org>; from puckwork@madz.net on Tue, Mar 27, 2001 at 08:48:08 +0200
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.27 Thomas Foerster wrote:
> 
> But suddenly the box was offline. One technical assistant from our ISP tried
> to reboot
> our server (he couldn't tell me if there had been any messages on the screen),
> but the
> system always hangs on 
> 
> Freeing unused kernel memory: xxk freed
> 

Try booting with init=/bin/bash, it looks like kernel gets a bad /sbin/init,
and gets stuck. Perhaps the shutdown damaged init, it starts to run and get
hung.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.2-ac25 #5 SMP Mon Mar 26 17:46:56 CEST 2001 i686

