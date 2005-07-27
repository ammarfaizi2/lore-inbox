Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVG0H6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVG0H6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 03:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVG0H6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 03:58:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56774 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262039AbVG0H5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 03:57:00 -0400
Date: Wed, 27 Jul 2005 00:55:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akihana@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Reclaim space from unused ramdisk?
Message-Id: <20050727005557.6e451f4c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507270951530.30941@yvahk01.tjqt.qr>
References: <4746469c05072615167ca234ce@mail.gmail.com>
	<Pine.LNX.4.61.0507270823490.10780@yvahk01.tjqt.qr>
	<20050726235624.4f3ca2a8.akpm@osdl.org>
	<Pine.LNX.4.61.0507270951530.30941@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> >> }
> >> 
> >
> >hmm, yes.  That's a special-case in the ramdisk driver.
> >
> >The command `blockdev --flushbufs /dev/ram0' should have the same effect.
> 
> Interesting. Command not found, here. URL?
> 

It ships with util-linux.  Weird that a distro would omit it.
