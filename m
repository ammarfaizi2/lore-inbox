Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWFJR2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWFJR2c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 13:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWFJR2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 13:28:32 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:14978 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751049AbWFJR2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 13:28:32 -0400
Date: Sat, 10 Jun 2006 19:28:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Roman Zippel <zippel@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
Message-ID: <20060610172807.GA15818@mars.ravnborg.org>
References: <44869397.4000907@tls.msk.ru> <Pine.LNX.4.64.0606080036250.17704@scrub.home> <e69fu3$5ch$1@terminus.zytor.com> <Pine.LNX.4.64.0606091409220.17704@scrub.home> <e6cgjv$b8t$1@terminus.zytor.com> <4489C83F.40307@tls.msk.ru> <Pine.LNX.4.64.0606100316400.17704@scrub.home> <448AF226.7060003@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448AF226.7060003@tls.msk.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 08:24:06PM +0400, Michael Tokarev wrote:
 
> Embedded folks are using uclibc or dietlibc - i see no reason for another
> "more small" libc for booting, regular tools (linked against uc or diet)
> can be used just fine.
Then they can just use uclibc or dietlibc. There is nothing that
prevents you from providing everything fr the initramfs.
klibc is the default choice so the kernel can provide a functional set
of programs. Without klibc it would be almost impossible to factor out
all the code that ought to run in userspace but are part of the ekrnel
because there were no other way to do it.

And klibc being temporary is some odd argument. Why should it be
temporary. Are there other alternatives when bundling a 'libc' with the
kernel?

	Sam
