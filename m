Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbTE0Qmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 12:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTE0Qmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 12:42:39 -0400
Received: from wall.ttu.ee ([193.40.254.238]:32266 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id S263932AbTE0Qmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 12:42:38 -0400
Date: Tue, 27 May 2003 19:55:42 +0300 (EET DST)
From: Siim Vahtre <siim@pld.ttu.ee>
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: 2.5.70-bk1 compilation error
Message-ID: <Pine.GSO.4.53.0305271949510.10781@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  CC [M]  drivers/video/i810/i810_main.o
In file included from drivers/video/i810/i810_main.c:56:
drivers/video/i810/i810.h:206: error: parse error before "agp_memory"
drivers/video/i810/i810.h:206: warning: no semicolon at end of struct or
union
drivers/video/i810/i810.h:207: warning: type defaults to `int' in
declaration of `i810_cursor_memory'
drivers/video/i810/i810.h:207: warning: data definition has no type or
storage class
drivers/video/i810/i810.h:208: error: parse error before '}' token
drivers/video/i810/i810.h:246: error: field `i810_gtt' has incomplete type
drivers/video/i810/i810_main.c: In function `i810fb_getcolreg':
drivers/video/i810/i810_main.c:1078: warning: comparison is always false
due to
limited range of data type
drivers/video/i810/i810_main.c: In function `i810fb_release_resource':
drivers/video/i810/i810_main.c:1887: error: dereferencing pointer to
incomplete
type
drivers/video/i810/i810_main.c:1889: error: dereferencing pointer to
incomplete
type
make[3]: *** [drivers/video/i810/i810_main.o] Error 1
make[2]: *** [drivers/video/i810] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

--
siim@void:~$ gcc --version
gcc (GCC) 3.3 (Debian)

CONFIG_DRM_I810=y
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y

