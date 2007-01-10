Return-Path: <linux-kernel-owner+w=401wt.eu-S965040AbXAJTbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbXAJTbd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 14:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbXAJTbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 14:31:32 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37835 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965040AbXAJTbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 14:31:32 -0500
Date: Wed, 10 Jan 2007 20:31:36 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: .version keeps being updated
Message-ID: <20070110193136.GA30486@aepfle.de>
References: <20070109102057.c684cc78.khali@linux-fr.org> <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org> <Pine.LNX.4.64.0701101426400.14458@scrub.home> <20070110181053.3b3632a8.khali@linux-fr.org> <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, Linus Torvalds wrote:

> Grr.

It did work for me for some reason, but I was wondering why it did work.

Cant we just invent a .data.uts section and put that into the
i386/x86_64/ia64/s390/powerpc vmlinux.lds.S files?
'"Linux version " UTS_RELEASE' in version.c

