Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTKIMYH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 07:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTKIMYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 07:24:07 -0500
Received: from mail.mediaways.net ([193.189.224.113]:26666 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S262427AbTKIMYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 07:24:05 -0500
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031109131018.GA18342@deneb.enyo.de>
References: <1067411342.1574.11.camel@localhost>
	 <20031109131018.GA18342@deneb.enyo.de>
Content-Type: text/plain
Message-Id: <1068380580.17223.5.camel@localhost>
Mime-Version: 1.0
Date: Sun, 09 Nov 2003 13:23:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-09 at 14:10, Florian Weimer wrote:
> Soeren Sonnenburg wrote:
> 
> > losetup -e blowfish /dev/loop0 /file
> > Password:
> > mkfs -t ext3 /dev/loop0
> > mount /dev/loop0 /mnt
> > <error unknown fs type>
> > <from here something was seriously broken... could not reboot anymore>
> 
> I'm seeing something similar, but in my case, mke2fs already crashes.

Yes... it crashes somewhen after writing to the loop device... sometimes
mkfs is enough, sometimes one has to write a bit more...

> > system is:
> > Linux no 2.6.0-test7 #8 Sun Oct 26 17:00:49 CET 2003 ppc GNU/Linux
> 
> Mine ist -test9 on x86.
> 
> Have you found a solution in the meantime?

not me.

Soeren.

