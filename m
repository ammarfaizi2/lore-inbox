Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUIFV2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUIFV2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUIFV2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:28:30 -0400
Received: from the-village.bc.nu ([81.2.110.252]:55970 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266864AbUIFV23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:28:29 -0400
Subject: Re: [2.6.7] kernel BUG at fs/jbd/transaction.c:1227!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Lohoff <flo@rfc822.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040906204135.GA9240@paradigm.rfc822.org>
References: <20040906204135.GA9240@paradigm.rfc822.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094502324.4531.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Sep 2004 21:25:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-06 at 21:41, Florian Lohoff wrote:
> Sep  6 20:22:03 source kernel: attempt to access beyond end of device
> Sep  6 20:22:03 source kernel: sdb1: rw=0, want=1803231528, limit=976784067
> Sep  6 20:22:03 source kernel: attempt to access beyond end of device
> Sep  6 20:22:03 source kernel: sdb1: rw=0, want=1080256520, limit=976784067
> Sep  6 20:22:03 source kernel: attempt to access beyond end of device
> Sep  6 20:22:03 source kernel: sdb1: rw=0, want=1121190792, limit=976784067
> Sep  6 20:22:03 source kernel: attempt to access beyond end of devic

All of these seem to be sensible block numbers if the top bit is flipped
back.  How much do you trust the hardware ?

