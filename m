Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTILWov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTILWov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:44:51 -0400
Received: from aneto.able.es ([212.97.163.22]:16076 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261838AbTILWou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:44:50 -0400
Date: Sat, 13 Sep 2003 00:44:47 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: Tosatti <marcelo@cyclades.com.br>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci.ids 2.4.23-pre3
Message-ID: <20030912224447.GA3917@werewolf.able.es>
References: <3F61FF67.7080504@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3F61FF67.7080504@wanadoo.es>; from xose@wanadoo.es on Fri, Sep 12, 2003 at 19:16:23 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.12, Xose Vazquez Perez wrote:
> hi,
> 
> here it goes a sync patch against latest pciids.sourceforge.net
> (Daily snapshot on Thu 2003-05-29 10:00:04)
> 

gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o gen-devlist gen-devlist.c
./gen-devlist <pci.ids
Line 1345: Device name too long
SiS650/651/M650/740 PCI/AGP VGA Display Adapter

Line 3081: Device name too long
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE

Changed to

    6325  SiS65x/M65x/740 PCI/AGP VGA Display Adapter

    0571  VT82C586x/C686x/33x/35 PIPC Bus Master IDE


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
