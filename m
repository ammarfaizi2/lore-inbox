Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265685AbTFNPob (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 11:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265686AbTFNPob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 11:44:31 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:19592 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265685AbTFNPoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 11:44:30 -0400
Date: Sat, 14 Jun 2003 18:01:55 +0200 (CEST)
From: Aschwin Marsman <a.marsman@aYniK.com>
X-X-Sender: marsman@localhost.localdomain
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-ac1
In-Reply-To: <200306141430.h5EEUuV31162@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0306141757240.1937-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jun 2003, Alan Cox wrote:

> Linux 2.4.21-ac1

When trying to do a make xconfig:

drivers/net/wan/Config.in: 44: can't handle dep_bool/dep_mbool/dep_tristate condition:
make[1]: *** [kconfig.tk] Error 1

      dep_bool '    Etinc PCISYNC features' CONFIG_DSCC4_PCISYNC
      dep_bool '    GPIO and PCI #RST pins wired together' CONFIG_DSCC4_PCI_RST

After :%s/dep_bool/bool/ make xconfig worked again.

Have a nice weekend,
 
Aschwin Marsman
 
--
aYniK Software Solutions         all You need is Knowledge
Bedrijvenpark Twente 305         NL-7602 KL Almelo - the Netherlands
P.O. box 134                     NL-7600 AC Almelo - the Netherlands
a.marsman@aYniK.com              http://www.aYniK.com

