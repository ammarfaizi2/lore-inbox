Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264606AbTFKWNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbTFKWNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:13:23 -0400
Received: from [212.97.163.22] ([212.97.163.22]:58346 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264606AbTFKWNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:13:20 -0400
Date: Thu, 12 Jun 2003 00:26:51 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: ecki@calista.eckenfels.6bone.ka-ip.net, linux-kernel@vger.kernel.org
Subject: Re: cachefs on linux
Message-ID: <20030611222651.GA2712@werewolf.able.es>
References: <200306101515.53464.rob@landley.net> <E19Q2S2-0001J0-00@calista.inka.de> <20030611.201218.66717787.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030611.201218.66717787.taka@valinux.co.jp>; from taka@valinux.co.jp on Wed, Jun 11, 2003 at 13:12:18 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.11, Hirokazu Takahashi wrote:
> Hello,
> 
> I think the main benfit of cachefs is on NFS servers. Cachefs of
> clients can help them to reduce their loads. We know many clients
> may share one huge NFS server.
> (e.g. Streaming systems which contents may be extremly huge.)
> 

Tha main use of cachefs I've seen was Sun's network-booting workstations.
We had a bunch of old suns (IPX, that was a 68k), with small disks
used to cache / , /usr and so on from an nfs server. You have the
benefits of just one centralized install and the ones from local
storage for more used files....

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc7-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
