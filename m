Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVFPW0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVFPW0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVFPW0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:26:16 -0400
Received: from [81.2.110.250] ([81.2.110.250]:35970 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261833AbVFPW0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:26:13 -0400
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:
	nobody cared!"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexander Fieroch <fieroch@web.de>, bzolnier@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20050615143039.24132251.akpm@osdl.org>
References: <d6gf8j$jnb$1@sea.gmane.org>
	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de>
	 <58cb370e05061401041a67cfa7@mail.gmail.com> <42B091EE.4020802@web.de>
	 <20050615143039.24132251.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118960606.24646.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Jun 2005 23:23:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-06-15 at 22:30, Andrew Morton wrote:
> Alexander Fieroch <fieroch@web.de> wrote:
> hm, I thought Alan did a driver for the ITE RAID controller?
> 
> I had a driver from ITE in the -mm tree for a while.  It still seems to
> apply and I think it fixes the compile warnings which you saw:

I did but it depends on other fixes to the IDE layer that never got in.
The -ac tree, Fedora and various other systems support IT8212, the Linus
kernel does not. Please direct any queries with regards to that to the
IDE maintainers as I've given up submitting IDE fixes to the base
kernel.

Alan

