Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266248AbUHWSKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUHWSKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUHWSKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:10:40 -0400
Received: from the-village.bc.nu ([81.2.110.252]:23954 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266248AbUHWSKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:10:34 -0400
Subject: Re: strange softdog message on 2.4.20 kernel...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Qvapul <pikpus@wp.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <412a2a39b5831@wp.pl>
References: <412a20af1d388@wp.pl>
	 <1093277771.29850.0.camel@localhost.localdomain>  <412a2a39b5831@wp.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093280907.29850.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 18:08:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 18:32, Matthew Qvapul wrote:
> So probably it means that redhat changed kernel configuration
> kernel between versions 2.4.18 and 2.4.20.
> 
> Do You approve the fact that my mashine was rebooted because of
> such kernel config ?

Good to know it works properly. I'd have to dig back but I think what
actually probably occurred is that 2.4.18 to 2.4.20 was the great
watchdog driver clean up when various drivers lacking "NOWAYOUT" support
got fixed properly upstream and a whole pile of other API variances got
cleaned up and resolved.

Alan

