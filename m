Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVH0Seb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVH0Seb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 14:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVH0Sea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 14:34:30 -0400
Received: from xenotime.net ([66.160.160.81]:20924 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964964AbVH0Sea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 14:34:30 -0400
Date: Sat, 27 Aug 2005 11:34:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "J. B." <ierland@mail.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel compile error in bootsplash.c
Message-Id: <20050827113427.4ab46fa3.rdunlap@xenotime.net>
In-Reply-To: <16842018.1125165215948.JavaMail.root@orville>
References: <16842018.1125165215948.JavaMail.root@orville>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2005 19:53:35 +0200 (CEST) J. B. wrote:

> I try to compile a 2.6.10 kernel but it stops with an error
> in bootsplash.c. I have everything set in my .config file in /usr/src/linux for bootsplash support. 
> 
> Anybody an idea. Where should i start to look? I am a newbie in kernel world

This is in a vendor kernel, right?
So please take it up with that vendor.

Kernels from kernel.org don't contain drivers/video/bootsplash/*


> in file included from drivers/video/bootsplash/bootsplash.c:18:
> include/linux/fb.h:869: error: array type has incomplete element type
> drivers/video/bootsplash/bootsplash.c:37: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:38: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:39: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:40: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:41: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:42: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:43: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:44: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:45: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:46: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:47: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:48: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:49: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:50: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c:52: warning: pointer targets in initialization differ in signedness
> drivers/video/bootsplash/bootsplash.c: In function 'splash_verbose':
> drivers/video/bootsplash/bootsplash.c:572: warning: pointer targets in passing argument 1 of 'splashcopy' differ in signedness
> drivers/video/bootsplash/bootsplash.c:572: warning: pointer targets in passing argument 2 of 'splashcopy' differ in signedness
> drivers/video/bootsplash/bootsplash.c: In function 'splash_prepare':
> drivers/video/bootsplash/bootsplash.c:642: warning: pointer targets in passing argument 1 of 'splashcopy' differ in signedness
> drivers/video/bootsplash/bootsplash.c: In function 'splash_write_proc':
> drivers/video/bootsplash/bootsplash.c:788: warning: pointer targets in passing argument 1 of 'boxit' differ in signedness
> drivers/video/bootsplash/bootsplash.c:789: warning: pointer targets in passing argument 1 of 'boxit' differ in signedness
> make[5]: *** [drivers/video/bootsplash/bootsplash.o] Error 1
> make[4]: *** [drivers/video/bootsplash] Error 2
> make[3]: *** [drivers/video] Error 2
> make[2]: *** [drivers] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.6.10'
> make[1]: *** [stamp-build] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.10'
> make: *** [stamp-buildpackage] Error 2
> -----------------------------------------------------


---
~Randy
