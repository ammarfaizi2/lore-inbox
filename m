Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVJ3SIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVJ3SIz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVJ3SIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:08:55 -0500
Received: from xenotime.net ([66.160.160.81]:7097 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932170AbVJ3SIy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:08:54 -0500
Date: Sun, 30 Oct 2005 10:08:53 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: <art@usfltd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.6.14-git1 - ieee1394 rev.1334 compilation problem !
Message-Id: <20051030100853.2aa2a197.rdunlap@xenotime.net>
In-Reply-To: <200510290936.AA1507856@usfltd.com>
References: <200510290936.AA1507856@usfltd.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2005 09:36:00 -0500 art wrote:

> 
> kernel-2.6.14-git1 - ieee1394 rev.1334 compilation problem !
> ....
>   CC [M]  drivers/ieee1394/csr.o
>   CC [M]  drivers/ieee1394/nodemgr.o
> drivers/ieee1394/nodemgr.c: In function ‘nodemgr_suspend_ne’:
> drivers/ieee1394/nodemgr.c:1295: error: too many arguments to function ‘ud->device.driver->suspend’
> drivers/ieee1394/nodemgr.c: In function ‘nodemgr_resume_ne’:
> drivers/ieee1394/nodemgr.c:1318: error: too many arguments to function ‘ud->device.driver->resume’
> make[2]: *** [drivers/ieee1394/nodemgr.o] Error 1
> make[1]: *** [drivers/ieee1394] Error 2
> make: *** [drivers] Error 2

I don't see that error with 2.6.14-git1 or -git2.
Did you download and apply -git1 ?

---
~Randy
