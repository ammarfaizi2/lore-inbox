Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTIHCY0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 22:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTIHCY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 22:24:26 -0400
Received: from main.gmane.org ([80.91.224.249]:35983 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261871AbTIHCYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 22:24:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: [BUG?] usb won't work with kernel 2.4.22
Date: Mon, 08 Sep 2003 04:20:15 +0200
Message-ID: <bjgp8j$ifk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: de, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a SIS735 chipset and i'm therefor using the usb-ohci module.
After upgrading from 2.4.21 to 2.4.22 my USB doens't work anymore.
lsusb doesn't show any devices - find /proc/bus/usb too.
On my laptop everything works fine with 2.4.22, but it has an intel 
chipset and uses UHCI instead of OHCI.

I read the Changelog and didn't find anything that looks like the reason 
for my trouble. I double checked that every module is there in my 2.4.22 
config. I even did "make oldconfig" after copying my config from the 
2.4.21 kernel.

With 2.4.22 my USB just look dead.
I also tried to copy usb-ohci.c from 2.4.21 to 2.4.22 and recompiled the 
kernel. Nothing changed (the diff wasn't that big, so i tried that).

Any ideas? If you need more information or just want me to try a patch 
just ask.

Thx
   Sven


