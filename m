Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbULPO0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbULPO0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbULPO0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:26:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:10370 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262681AbULPOYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:24:19 -0500
Subject: Re: What if?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41C0F67D.4000506@zytor.com>
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org>
	 <1101976424l.5095l.0l@werewolf.able.es>
	 <1101984361.28965.10.camel@tara.firmix.at>
	 <cpkc5i$84f$1@terminus.zytor.com>  <1102972125l.7475l.0l@werewolf.able.es>
	 <1103158646.3585.35.camel@localhost.localdomain>
	 <41C0F67D.4000506@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103203426.3804.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 13:23:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 02:44, H. Peter Anvin wrote:
> Yes, but there is also no really big deal compiling C code with a C++ 
> compiler.  Yes, it was a disaster in 0.99.14, but that was 10 years ago.

g++ is still much slower. We don't know how many bugs it would show up
in the compiler and tools either, especially on embedded platforms.
Finally the current kernel won't go through a C++ compiler because we
use variables like "new" quite often.

