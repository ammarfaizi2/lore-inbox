Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbUBVTsA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 14:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUBVTsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 14:48:00 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35475 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261734AbUBVTr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 14:47:57 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Sam Ravnborg <sam@ravnborg.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [1/3] kgdb-lite for 2.6.3
Date: Sun, 22 Feb 2004 20:54:25 +0100
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>
References: <20040222160417.GA9535@elf.ucw.cz> <20040222202211.GA2063@mars.ravnborg.org>
In-Reply-To: <20040222202211.GA2063@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402222054.25332.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 of February 2004 21:22, Sam Ravnborg wrote:
> Just some random comments after browsing the code.
>
> 	Sam
>
> > +
> > +int kgdb_hexToLong(char **ptr, long *longValue);
>
> A patch has been posted by Tom Rini to convert this to the
> linux naming: kgdb_hex2long(...).
>
> +static const char hexchars[] = "0123456789abcdef";
> Grepping after 0123456789 in the src tree gives a lot of hits.
> Maybe we should pull in some functionality from klibc, and place it in lib/
> at some point in time.

It is already there, in lib/vsprintf.c: simple_strtoul() and simple_strtol().

--bart

