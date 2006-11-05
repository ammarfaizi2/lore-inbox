Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965767AbWKEBCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965767AbWKEBCH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 20:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965768AbWKEBCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 20:02:07 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45468 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965767AbWKEBCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 20:02:06 -0500
Subject: Re: [PATCH 2.6.19-rc4-mm2] epca get_termio cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <454D03B8.1080507@gmail.com>
References: <200611042148.16096.m.kozlowski@tuxland.pl>
	 <454D03B8.1080507@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 05 Nov 2006 01:06:16 +0000
Message-Id: <1162688776.21654.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-11-04 am 22:18 +0059, ysgrifennodd Jiri Slaby:
> Mariusz Kozlowski wrote:
> > Hello,
> > 
> > The code using get_termio was already '#if 0' but get_termio itself was not. 
> 
> You would rather wipe it out or better, wipe the whole driver out, we have an
> ack from Digi ;).

With the existing kernel code drivers should not have implemented their
own TC* functions for termio/termios. Some did and are broken, very
shortly they will be far more broken. Certain USB offenders will need
fixing.

Alan

