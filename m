Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311902AbSCVKaI>; Fri, 22 Mar 2002 05:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311941AbSCVK37>; Fri, 22 Mar 2002 05:29:59 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6667 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311900AbSCVK3m>; Fri, 22 Mar 2002 05:29:42 -0500
Message-ID: <3C9B0723.703DC486@zip.com.au>
Date: Fri, 22 Mar 2002 02:27:47 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Martin Blais <blais@iro.umontreal.ca>, linux-kernel@vger.kernel.org
Subject: Re: xxdiff as a visual diff tool (shameless plug)
In-Reply-To: <20020321061423.HIXG2746.tomts17-srv.bellnexxia.net@there> <20020322092712.GA233@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> It would be great to somehow split patches before feeding them to the
> patch. If you have one big hunk, and it fails because of one letter
> added somewhere in file, it is *big pain* to find/kill offending
> letter.

yup.  It's a *lot* easier if the diff was generated with `diff -1',
because that makes many more hunks.

There is sufficient information in a normal diff to turn it into
a `diff -1' diff, I think.  All it needs is for Tim^Wsomeone to code it.

-
