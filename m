Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVFRKyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVFRKyk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 06:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVFRKye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 06:54:34 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:57517 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262102AbVFRKy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 06:54:29 -0400
Message-ID: <42B3FD60.5060208@ens-lyon.org>
Date: Sat, 18 Jun 2005 12:54:24 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Willy Tarreau <willy@w.ods.org>,
       Linus Torvalds <torvalds@osdl.org>, Keith Owens <kaos@ocs.com.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12
References: <21446.1119073126@ocs3.ocs.com.au> <20050618065911.GH8907@alpha.home.local> <Pine.LNX.4.62.0506181231410.2653@dragon.hyggekrogen.localhost> <200506181448.34181.adobriyan@gmail.com>
In-Reply-To: <200506181448.34181.adobriyan@gmail.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------020001070406080603030707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020001070406080603030707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Le 18.06.2005 12:48, Alexey Dobriyan a écrit :
> On Saturday 18 June 2005 14:36, Jesper Juhl wrote:
> 
>>--- linux-2.6.12-orig/Documentation/dontdiff
>>+++ linux-2.6.12/Documentation/dontdiff
>>@@ -138,3 +138,4 @@
>> wanxlfw.inc
>> uImage
>> zImage
>>+pax_global_header
> 
> 
> In alphabetic order, please.

Then uImage is not at the right place :)
Patch attached.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Brice

--------------020001070406080603030707
Content-Type: text/x-patch;
 name="fix-dontdiff-alphabetical-order.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-dontdiff-alphabetical-order.patch"

--- linux-2.6.12/Documentation/dontdiff.old	2005-06-18 12:51:47.000000000 +0200
+++ linux-2.6.12/Documentation/dontdiff	2005-06-18 12:52:03.000000000 +0200
@@ -130,11 +130,11 @@ tags
 times.h*
 tkparse
 trix_boot.h
+uImage
 version.h*
 vmlinux
 vmlinux-*
 vmlinux.lds
 vsyscall.lds
 wanxlfw.inc
-uImage
 zImage

--------------020001070406080603030707--
