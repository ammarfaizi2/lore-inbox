Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129909AbRBVEfR>; Wed, 21 Feb 2001 23:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130178AbRBVEfH>; Wed, 21 Feb 2001 23:35:07 -0500
Received: from [200.222.195.191] ([200.222.195.191]:16307 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129909AbRBVEet>; Wed, 21 Feb 2001 23:34:49 -0500
Date: Thu, 22 Feb 2001 01:33:08 -0300
From: Frédéric L. W. Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.2
Message-ID: <20010222013308.Y21068@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
X-Mailer: Mutt/1.3.14i - Linux 2.4.1
X-URL: http://www.pervalidus.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eloy A. Paris wrote:

> I solved the problem by changing all calls to ld in
> /usr/src/linux/arch/i386/boot/Makefile from "ld ... -oformat
> ..." to "ld ... --oformat ..."

Right. This is a change on binutils 2.10.1.0.7 and up (now at
2.10.91.0.2). A few people sent a patch to the list (Andreas
Jaeger was the first), but it wasn't added to 2.4.2...

Jaeger's message:

http://marc.theaimsgroup.com/?l=linux-kernel&m=98180656028765&w=2

More at the Changelog:

http://ftp.valinux.com/pub/support/hjl/binutils/release.binutils-2.10.91.0.2

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
