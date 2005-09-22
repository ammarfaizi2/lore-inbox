Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVIVDqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVIVDqS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 23:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVIVDqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 23:46:18 -0400
Received: from mail.dvmed.net ([216.237.124.58]:32680 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030204AbVIVDqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 23:46:18 -0400
Message-ID: <43322900.7050500@pobox.com>
Date: Wed, 21 Sep 2005 23:46:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ISDN USB build breakage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Latest -git tree 'make allmodconfig' build breaks on 32-bit x86:

   CC [M]  drivers/isdn/hisax/st5481_usb.o
drivers/isdn/hisax/st5481_usb.c: In function `st5481_in_mode':
drivers/isdn/hisax/st5481_usb.c:648: error: `URB_ASYNC_UNLINK' 
undeclared (first use in this function)
drivers/isdn/hisax/st5481_usb.c:648: error: (Each undeclared identifier 
is reported only once
drivers/isdn/hisax/st5481_usb.c:648: error: for each function it appears 
in.)


