Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270433AbTGSAGh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 20:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270435AbTGSAGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 20:06:36 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:16851 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S270433AbTGSAGf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 20:06:35 -0400
Date: Fri, 18 Jul 2003 20:21:31 -0400
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre7
Message-ID: <20030719002131.GA5924@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on alpha:

gcc -D__KERNEL__ -I/src/build/linux-2.4.22-pre7-part-build/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mno-fp-regs -ffixed-8 -mcpu=ev67 -Wa,-mev6
-nostdinc -iwithprefix include -DKBUILD_BASENAME=api  -DEXPORT_SYMTAB -c
api.c
In file included from api.c:21:
internal.h:19:28: asm/kmap_types.h: No such file or directory
In file included from api.c:21:
internal.h:24: error: return type is an incomplete type
internal.h: In function rypto_kmap_type':
internal.h:25: error: invalid use of undefined type num km_type'
internal.h:25: warning: eturn' with a value, in function returning void

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
