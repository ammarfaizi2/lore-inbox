Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTDTRND (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 13:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTDTRND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 13:13:03 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:64663 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263636AbTDTRNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 13:13:02 -0400
Subject: Re: 2.5.68 kernel no initrd
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Dave Mehler <dmehler26@woh.rr.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <000701c306f6$cf100180$0200a8c0@satellite>
References: <000701c306f6$cf100180$0200a8c0@satellite>
Content-Type: text/plain
Organization: 
Message-Id: <1050859494.595.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 20 Apr 2003 19:24:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-20 at 06:39, Dave Mehler wrote:
>     Ok, i should learn to leave well enough alone, but i don't. After
> successfully installing a monolithic 2.5.67 kernel i decided i wanted
> modules, so i made them, and what happened, it hung after the initrd
> initialized. So, when 2.5.68 came out i of course grab it, compile/install
> it without a hitch, but for one thing, as of now make install did not make
> an initrd for that install. Does anyone know how to make this manually, it
> won't boot without one?

I don't have experience with initrd, but why would you want a initrd?
Can't you simply build into the kernel the required pieces to mount the
root filesystem and leave the rest as loadable modules?
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

