Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVAJTvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVAJTvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVAJTvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:51:16 -0500
Received: from mail108.messagelabs.com ([216.82.255.115]:19132 "HELO
	mail108.messagelabs.com") by vger.kernel.org with SMTP
	id S262481AbVAJTte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:49:34 -0500
X-VirusChecked: Checked
X-Env-Sender: AAnthony@sbs.com
X-Msg-Ref: server-7.tower-108.messagelabs.com!1105386571!7045362!1
X-StarScan-Version: 5.4.5; banners=sbs.com,-,-
X-Originating-IP: [204.255.71.6]
Message-ID: <4F23E557A0317D45864097982DE907941A3383@pilotmail.sbscorp.sbs.com>
From: Adam Anthony <AAnthony@sbs.com>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Alexey Dobriyan <adobriyan@mail.ru>
Cc: Adam Anthony <AAnthony@sbs.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH] /driver/net/wan/sbs520
Date: Mon, 10 Jan 2005 12:49:23 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the heads up A&M.  I have destroyed the evil [^M]'s, and
updated the package.
http://prdownloads.sourceforge.net/sbs520lnxdrv/sbs520patch.bz2?download
-AA


-----Original Message-----
From: Matthias-Christian Ott [mailto:matthias.christian@tiscali.de] 
Sent: Monday, January 10, 2005 12:26 PM
To: Alexey Dobriyan
Cc: Adam Anthony; netdev@oss.sgi.com; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /driver/net/wan/sbs520

Alexey Dobriyan wrote:

>On Mon, 10 Jan 2005 07:46:52 -0700, Adam Anthony wrote:
>
>  
>
>>With the permission of my employer, SBS Technologies, Inc., I have
>>released a patch for 2.4 kernels that supports the 520 Series of WAN
>>adapters.
>>    
>>
>
>My editor shows ^M at the end of every line of new
Documentation/Configure.help,
>MAINTAINERS (add ~63400 bogus lines!). Please, look at the patch _after_
>generating it.
>
>  
>
>>+obj-$(CONFIG_LANMEDIA)		+=		syncppp.o^M
>>    
>>
>
>  
>
>>+subdir-$(CONFIG_LANMEDIA) += lmc^M
>>    
>>
>
>Also random ^M's.
> 
>--- linux-2.4.28-virgin/drivers/net/wan/sbs520/lnxosl.c
>+++ /usr/src/linux-2.4.28/drivers/net/wan/sbs520/lnxosl.c
>
>  
>
>>+// Programming Language:	C^M
>>+// Target Processor:		Any^M
>>+// Target Operating System: Linux^M
>>    
>>
>
>Well, this is pretty obvious to everyone here. :-)
>
>  
>
>>+// This software may be used and distributed according to the terms^M
>>+// of the GNU General Public License, incorporated herein by reference.^M
>>    
>>
>
>Stupid question: do you mean GPL version 2 or something else?
>
>	Alexey
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
That's ugly, that are Microsoft line endings.

Matthias-Christian Ott

***This message has been scanned for virus, spam, and undesirable
content.***
***For further information, contact your mail administrator.***

For limitations on the use and distribution of this message, please visit www.sbs.com/emaildisclaimer.
