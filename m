Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbWASA6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbWASA6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbWASA6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:58:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:5373 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161126AbWASA6C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:58:02 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: spereira@tusc.com.au
Subject: Re: 32 bit (socket layer) ioctl emulation for 64 bit kernels
Date: Thu, 19 Jan 2006 01:57:37 +0100
User-Agent: KMail/1.9.1
Cc: YOSHIFUJI Hideaki /
	 =?utf-8?q?=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?= 
	<yoshfuji@linux-ipv6.org>,
       acme@ghostprotocols.net, ak@muc.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, pereira.shaun@gmail.com,
       Arnd Bergmann <arnd@arndb.de>
References: <1137122079.5589.34.camel@spereira05.tusc.com.au> <200601170115.07019.arnd@arndb.de> <1137567396.14130.2.camel@spereira05.tusc.com.au>
In-Reply-To: <1137567396.14130.2.camel@spereira05.tusc.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601190157.38277.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wednesday 18 January 2006 07:56 schrieb Shaun Pereira:
>  Assuming you are happy with the state of the patches, is there anyway
> for me to know if they will become a part of the next release?

I don't see any more technical problems with your patches. You still need
to proper patch description and Signed-off-by: line like it is described
in Documentation/SubmittingPatches.
You can add an 'Acked-by: Arnd Bergmann <arnd@arndb.de>' line to the four
patches you posted last if you like.

> Usually submitted/reviewed patches to netdev does not not always
> guarantee they will be acccepted/signed-off.
> Any advice would be useful

I'm not that familiar with the process for non-driver patches for netdev
(nor for device drivers as it seems ;-)), but my understanding is that you 
should address those to Jeff Garzik as well, asking for inclusion in the
netdev-2.6 git tree in your introductory '[PATCH 0/4]' mail.

Since the official merge window for 2.6.16 is now over (2.6.16-rc1 has been
released), it may have to wait for 2.6.17 to become part of the mainline
kernel, that probably depends on Jeffs judgement.

I would think it can still go in since it is a bug fix for the execution of
32 bit programs using x25 ioctls, but it's clearly not my decision ;-).

	Arnd <><
