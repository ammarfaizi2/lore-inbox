Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVABPnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVABPnH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 10:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVABPmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 10:42:32 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:50349 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261261AbVABPlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 10:41:12 -0500
Subject: Re: printk loglevel policy?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, David Howells <dhowells@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <2cd57c9004123018203b7e38ef@mail.gmail.com>
References: <Pine.LNX.4.61.0412310259230.4725@dragon.hygekrogen.localhost>
	 <2cd57c9004123018203b7e38ef@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104675855.15004.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 02 Jan 2005 14:36:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-31 at 02:20, Coywolf Qi Hunt wrote:
> Hi all, 
> 
> Recently, I've seen a lot of add loglevel to printk patches. 
> grep 'printk("' -r | wc shows me 2433. There are probably 2433 printk
> need to patch, is it?  What's this printk loglevel policy, all these

You would need to work out which were at the start of a newline - most
of them are probably just fine and valid

