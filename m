Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTDREC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 00:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbTDREC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 00:02:56 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:22487 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262811AbTDRECz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 00:02:55 -0400
Subject: Re: rh9 2.5 kernel additional information
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Dave Mehler <dmehler26@woh.rr.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <000501c30514$486cf1d0$0200a8c0@satellite>
References: <000501c30514$486cf1d0$0200a8c0@satellite>
Content-Type: text/plain
Organization: 
Message-Id: <1050639276.595.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 18 Apr 2003 06:14:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-17 at 21:05, Dave Mehler wrote:
>     Adding to my previous message, i reran the kernel configuration. I
> ensured that the keyboard, mouse, and display settings were set right, and
> that my processor and loadable module settings are also right. The only
> thing i added was framebuffer console support, but that didn't make a
> difference, after it hit the initrd it just hung. Any ideas?

Just out of curiosity, why do you need an initrd? Just compile all
things required to boot into the kernel (like
ext2/ext3/whateverfilesystemyouuse) and if you want, leave the rest as
modules. I have never ever used initrd on my self-compiled kernels.
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

