Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVGAVTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVGAVTN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVGAVRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 17:17:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:47754 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261576AbVGAVRI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 17:17:08 -0400
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-os@analogic.com
Cc: Andi Kleen <ak@suse.de>, Christoph Lameter <christoph@lameter.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0507011637460.5213@chaos.analogic.com>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net.suse.lists.linux.kernel>
	 <p73r7emuvi1.fsf@verdi.suse.de>
	 <Pine.LNX.4.62.0506281238320.1734@graphe.net>
	 <20050629024903.GA21575@bragg.suse.de>
	 <Pine.LNX.4.62.0507011302090.19234@graphe.net>
	 <20050701202805.GF21330@wotan.suse.de>
	 <Pine.LNX.4.61.0507011637460.5213@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1120252438.15069.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 01 Jul 2005 22:13:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-01 at 21:47, Richard B. Johnson wrote:
> After all modules are loaded, you (startup) loads a module that
> makes the module-loader stuff return -ENOSYS. Then, nobody can
> load any new modules. The running kernel is (more) secure.

Just use an SELinux policy like everyone else 8). You need to block more
otherwise I can load a module by hand through /dev/mem etc

Alan
--
        " If knowledge does not have owners, then intellectual property
                is a trap set by neo-liberalism." -- Hugo Chavez

