Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUG1V5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUG1V5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUG1V5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:57:52 -0400
Received: from hierophant.serpentine.com ([66.92.13.71]:49840 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S265108AbUG1V5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:57:40 -0400
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Jens Axboe <axboe@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040728170507.GK10377@suse.de>
References: <1090989052.3098.6.camel@camp4.serpentine.com>
	 <20040728053107.GB11690@suse.de>
	 <c93051e8040727235123a6ed67@mail.gmail.com>
	 <20040728065319.GD11690@suse.de> <20040728145228.GA9316@redhat.com>
	 <20040728145543.GB18846@devserv.devel.redhat.com>
	 <20040728163353.GJ10377@suse.de>  <20040728170507.GK10377@suse.de>
Content-Type: text/plain
Date: Wed, 28 Jul 2004 14:57:37 -0700
Message-Id: <1091051858.13651.1.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 19:05 +0200, Jens Axboe wrote:

> On this thread, I agree it's
> probably a kernel issue. Can you check what capacity isosize gives you
> on the device, and what /proc/ide/hdc/capacity tells you?

This is a basically unpatched 2.6.7 kernel:

~ # uname -a
Linux abcd.serpentine.com 2.6.7-1.1791-up #1 Sat Jul 10 14:22:15 PDT
2004 i686 athlon i386 GNU/Linux

~ # isosize /dev/hdc
8164939776

~ # cat /proc/ide/hdc/capacity
15947148

	<b

