Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbTJNIfk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 04:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTJNIfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 04:35:40 -0400
Received: from [213.229.38.66] ([213.229.38.66]:54475 "HELO mail.falke.at")
	by vger.kernel.org with SMTP id S262236AbTJNIfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 04:35:38 -0400
Message-ID: <3F8BB43A.9050808@winischhofer.net>
Date: Tue, 14 Oct 2003 10:30:50 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: James Simmons <jsimmons@infradead.org>, Olaf Hering <olh@suse.de>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: gcc -msoft-float [Was: Linux 2.6.0-test7 - stability freeze]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote:
 >drivers/built-in.o(.text+0x5c24f7):drivers/video/sis/sis_main.c:655: 
 >undefined \
 >reference to `__floatsidf' \
 >drivers/built-in.o(.text+0x5c2510):drivers/video/sis/sis_main.c:655: 
 >undefined \
 >reference to `__divdf3' \
 >drivers/built-in.o(.text+0x5c251b):drivers/video/sis/sis_main.c:656: 
 >undefined \
 >reference to `__floatsidf' \
 >drivers/built-in.o(.text+0x5c2534):drivers/video/sis/sis_main.c:656: 
 >undefined \
 >reference to `__divdf3' \
 >drivers/built-in.o(.text+0x5c2540):drivers/video/sis/sis_main.c:656: 
 >undefined \
 >reference to `__adddf3' \
 >drivers/built-in.o(.text+0x5c2554):drivers/video/sis/sis_main.c:656: 
 >undefined \
 >reference to `__adddf3' \
 >drivers/built-in.o(.text+0x5c255c):drivers/video/sis/sis_main.c:656: 
 >undefined \
 >reference to `__fixunsdfsi' \
 >drivers/built-in.o(.text+0x5c28b8):drivers/video/sis/sis_main.c:675: 
 >undefined \
 >reference to `__adddf3' \
 >drivers/built-in.o(.text+0x5c28d1):drivers/video/sis/sis_main.c:675: 
 >undefined \
 >reference to `__adddf3' \
 >drivers/built-in.o(.text+0x5c28ea):drivers/video/sis/sis_main.c:675: 
 >undefined \
 >reference to `__adddf3' drivers/built-in.o(.init.text+0x6252d): In 
 >function \
 >`sisfb_init': drivers/video/sis/sis_main.c:4450: undefined reference 
to >`__floatsidf'
 >drivers/built-in.o(.init.text+0x6253f):drivers/video/sis/sis_main.c:4450: >undefined \
 >reference to `__divdf3' \
 >drivers/built-in.o(.init.text+0x62547):drivers/video/sis/sis_main.c:4450: >undefined \
 >reference to `__fixunsdfsi'


This is fixed in the latest version of sisfb I sent to James Simmons; 
one more reason to merge the fbdev stuff...

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org



