Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUBWKmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 05:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbUBWKmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 05:42:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:16076 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261906AbUBWKmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 05:42:16 -0500
Message-ID: <4039D976.5080103@paceblade.com>
Date: Mon, 23 Feb 2004 11:44:06 +0100
From: Robert Woerle <robert@paceblade.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040113
X-Accept-Language: de, en, de-at, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ttyS0 why hardcoded to 3F8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:b4ac6117e991eeeca15f2be66d9fb0df
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am working here at a Tablet PC with serial touscreen controller .
For whatever reason this controller now is configured to have COM1 at 
0x220 and not at 3F8 .
Is the aera of the "wellknown legacy " ports over and therefore it is 
becoming more rare that wellknown IO are dissapearing.

Would it be therefore worth investigating the possibility to not 
hardcode this in include/asm-i386/serial.h ?
Or am i just in a lucky situation that some littel taiwanese did make a 
joke of the week and programmed the serial at this IO ?

Since i got it working now with a patch include/asm-i386/serial.h and 
kinda fine with it.
Of course i would love to have the ability to maybe load the serial 
driver ( serial.o ) with a paramter telling where to search ?

Or could it be a easy thing to have a addittional module loaded which 
changes this config at runtime ... so i dont need a "special patched " 
kernel ?

Just curious Robert
-- 
____________________________________
*Robert Woerle
*
*Technical Product Manager

2L Computers BV*
*
*Niederlassung Deutschland*
*Pace/Blade/ /- /Commodore - Conceptronic*
** 
*
phone: 	+49 89 552 999 34
fax: 	+49 89 552 999 10
email: 	robert@paceblade.com <mailto:robert@paceblade.com>
web: 	http://www.paceblade.com <http://www.paceblade.com/>
_____________________________________







