Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbUJ0RRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbUJ0RRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbUJ0RQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:16:39 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:39071 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262542AbUJ0RMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:12:32 -0400
Subject: Re: Would auto setting CONFIG_RTC make sense when building SMP
	kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410262108041.3277@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410262108041.3277@dragon.hygekrogen.localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098893383.4304.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Oct 2004 17:09:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-10-26 at 20:13, Jesper Juhl wrote:
> Isn't it always desirable to be able to set the clock in an SMP compatible 
> fashion if the kernel is indeed build for SMP?

Probably it is best to just move it to CONFIG_EMBEDDED. Without the
driver the clock binary bitbangs the cmos and that isnt safe non SMP
either nowdays

