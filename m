Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTFPL51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 07:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTFPL51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 07:57:27 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:3496 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263782AbTFPL50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 07:57:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16109.46049.642890.221618@gargle.gargle.HOWL>
Date: Mon, 16 Jun 2003 14:11:13 +0200
From: mikpe@csd.uu.se
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: perfctr-2.5.5 released
In-Reply-To: <p73d6he4hr5.fsf@oldwotan.suse.de>
References: <200306152229.h5FMTa93026063@harpo.it.uu.se.suse.lists.linux.kernel>
	<p73d6he4hr5.fsf@oldwotan.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > mikpe@csd.uu.se writes:
 > 
 > > Version 2.5.5 of perfctr, the Linux/x86 performance
 > > monitoring counters driver, is now available at the usual
 > > place: http://www.csd.uu.se/~mikpe/linux/perfctr/
 > > 
 > > x86-64 users please note that the 2.5.71 kernel won't
 > > compile on x86-64 due to incomplete 'driver model' changes.
 > 
 > Hmm? It compiles just fine here even without any patches
 > with the defconfig. Ok there are some warnings, but these can be 
 > safely ignored.

CONFIG_PM is broken; I admit I never tested with PM off.

 > Of course you are usually better off when you apply the current
 > patchkit from ftp://ftp.x86-64.org/pub/linux/v2.5/

I looked at www.x86-64.org, but couldn't find anything 2.5-related.

 > > A patch to fix this and two other x86-64 bugs is in the
 > > patch-x86_64-2.5.71 file in perfctr's download directory.
 > 
 > When you fix x86-64 bugs you should submit the patches.

Sure, as soon as I have time. I needed to get this release done first.

/Mikael
