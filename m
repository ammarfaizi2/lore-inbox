Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUABCCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 21:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUABCCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 21:02:12 -0500
Received: from pD9526784.dip.t-dialin.net ([217.82.103.132]:57984 "EHLO
	fred.muc.de") by vger.kernel.org with ESMTP id S261872AbUABCCM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 21:02:12 -0500
To: Leon Toh <tltoh@attglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel  
 Configuration Tool
From: Andi Kleen <ak@muc.de>
Date: Fri, 02 Jan 2004 03:02:10 +0100
In-Reply-To: <19lcU-64y-19@gated-at.bofh.it> (Leon Toh's message of "Fri, 02
 Jan 2004 01:20:12 +0100")
Message-ID: <m3n097hzvh.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <19aKu-6Z-17@gated-at.bofh.it> <19aKu-6Z-19@gated-at.bofh.it>
	<19aKu-6Z-21@gated-at.bofh.it> <19aKu-6Z-23@gated-at.bofh.it>
	<19aKu-6Z-25@gated-at.bofh.it> <19aKu-6Z-15@gated-at.bofh.it>
	<19lcU-64y-19@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Toh <tltoh@attglobal.net> writes:

> I totally agree with you. However at the time when this driver was
> written it was only intended for Intel i386 base architecture. And
> furthermore AMD64 wasn't even available at that stage.

But other 64bit architectures were like IA64. It was very short sightened,
especially since it doesn't require much effort to write 64bit clean
code from the beginning.

> At this point of time I think fixing this driver for 32bit
> architecture now is far more important than addressing 64bit
> architecture, don't you agree Andi ?

Unclear. The number of 2.4/AMD64 users tripping over this might
be not much smaller than the number of early 2.6 adopter 32bit users.

-Andi
