Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbULPUw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbULPUw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbULPUw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:52:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24493 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261997AbULPUwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:52:55 -0500
Date: Thu, 16 Dec 2004 21:52:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What if?
In-Reply-To: <41C1F20E.2030903@zytor.com>
Message-ID: <Pine.LNX.4.61.0412162151500.18903@yvahk01.tjqt.qr>
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org> 
 <1101976424l.5095l.0l@werewolf.able.es>  <1101984361.28965.10.camel@tara.firmix.at>
  <cpkc5i$84f$1@terminus.zytor.com>  <1102972125l.7475l.0l@werewolf.able.es>
  <1103158646.3585.35.camel@localhost.localdomain>  <41C0F67D.4000506@zytor.com>
 <1103203426.3804.16.camel@localhost.localdomain> <41C1F20E.2030903@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> g++ is still much slower. We don't know how many bugs it would show up
>> in the compiler and tools either, especially on embedded platforms.
>> Finally the current kernel won't go through a C++ compiler because we
>> use variables like "new" quite often.
>
> -Dnew=_New, problem solved.

It's not that easy. Just when you expect it least, a few tiny sourcecode bits 
already use new (in the C++ sense) and whoops:
	int *b = _New int[4];
(self-explanatory)





Jan Engelhardt
-- 
ENOSPC
