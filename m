Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbULRLOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbULRLOX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 06:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbULRLOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 06:14:23 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:42931 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262205AbULRLOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 06:14:21 -0500
Date: Sat, 18 Dec 2004 12:14:20 +0100
From: Andi Kleen <ak@suse.de>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: Andi Kleen <ak@suse.de>, Crazy AMD K7 <snort2004@mail.ru>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: do_IRQ: stack overflow: 872..
Message-ID: <20041218111420.GE338@wotan.suse.de>
References: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel> <p73zn0ccaee.fsf@verdi.suse.de> <1103368330.3566.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103368330.3566.15.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The bridge-nf code does not use recursive function calls and there is no
> long consecutive function calling. Furthermore, there is no function in
> the bridge-nf code that uses a large part of the stack.

Just take a look at the backtrace in the original post. It clearly
shows a problem. And it points strongly towards br-netfilter.

