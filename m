Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbTBDHfy>; Tue, 4 Feb 2003 02:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267142AbTBDHfy>; Tue, 4 Feb 2003 02:35:54 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:53521 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267141AbTBDHfx>; Tue, 4 Feb 2003 02:35:53 -0500
Message-Id: <200302040738.h147c8s10723@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jared Young <headgeek@li.nu-x.net>, linux-kernel@vger.kernel.org
Subject: Re: Small bug in linux-2.4.20/include/linux/kernel.h
Date: Tue, 4 Feb 2003 09:36:28 +0200
X-Mailer: KMail [version 1.3.2]
References: <20030130235853.7a2b4dcb.headgeek@li.nu-x.net>
In-Reply-To: <20030130235853.7a2b4dcb.headgeek@li.nu-x.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 January 2003 06:58, Jared Young wrote:
> Perhaps this is a small bug: During a compile for 2.4.20 there comes
> a section in /include/linux/kernel.h that calls for #include
> <stdarg.h> however stdarg.h is not included or found in any of the
> source directories. I cannot go on with my kernel make without this
> as it fails every 'make bzImage' any suggestions. I have included my
> makemenuconfig file for examination. What does stdarg.h call for on
> and where can I get this file if needed?

/me too has nonstandard GCC installation. I use this instead of plain make:

CFLAGS=-std=gnu99 \
GCC_EXEC_PREFIX=/usr/app/gcc-3.2/lib/gcc-lib/ \
QTDIR=/usr/app/qt-3.0.3posix \
make ...

Adapt as needed...
--
vda
