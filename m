Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752317AbWCFJKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbWCFJKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbWCFJKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:10:44 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:1168 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1752315AbWCFJKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:10:43 -0500
Message-ID: <440BFC8A.1030607@aitel.hist.no>
Date: Mon, 06 Mar 2006 10:10:34 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: 2.6.16-rc5-mm2 compile error in urb.c
References: <20060303045651.1f3b55ec.akpm@osdl.org>
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.6.16-rc5-mm2 stopped here:

  CC      drivers/usb/core/urb.o
drivers/usb/core/urb.c: In function ‘usb_alloc_urb’:
drivers/usb/core/urb.c:65: error: dereferencing pointer to incomplete type
drivers/usb/core/urb.c: In function ‘usb_submit_urb’:
drivers/usb/core/urb.c:329: error: dereferencing pointer to incomplete type
make[3]: *** [drivers/usb/core/urb.o] Error 1
make[2]: *** [drivers/usb/core] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2


Helge Hafting
