Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTIHXeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTIHXeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:34:19 -0400
Received: from [204.253.162.40] ([204.253.162.40]:30869 "EHLO
	skull.piratehaven.org") by vger.kernel.org with ESMTP
	id S263786AbTIHXeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:34:18 -0400
Date: Mon, 8 Sep 2003 16:34:07 -0700
From: Dale Harris <rodmur@maybe.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: USBNET in Linux 2.6.0-test5
Message-ID: <20030908233407.GT16695@maybe.org>
Mail-Followup-To: Dale Harris <rodmur@maybe.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on i386.

got this error while compiling:

drivers/usb/net/usbnet.c:2953: #error You need to configure some
hardware for this driver
drivers/usb/net/usbnet.c:303: warning: `always_connected' defined but
not used
make[4]: *** [drivers/usb/net/usbnet.o] Error 1
make[3]: *** [drivers/usb/net] Error 2
make[2]: *** [drivers/usb] Error 2
make[1]: *** [drivers] Error 2


So we have to configure hardware just to compile a kernel?

-- 
Dale Harris   
rodmur@maybe.org
/.-)
