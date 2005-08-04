Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVHDLCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVHDLCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 07:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVHDLCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 07:02:54 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:12165 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262479AbVHDLCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 07:02:39 -0400
Message-ID: <42F1F56E.5020300@gmail.com>
Date: Thu, 04 Aug 2005 13:01:02 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       Jiri Slaby <lnx4us@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2.6.13-rc4-mm1] Re: Obsolete files in 2.6 tree
References: <42DED9F3.4040300@gmail.com> <42DF6F34.4080804@gmail.com>	 <20050726120727.GA2134@ucw.cz> <1122421245.2542.35.camel@localhost.localdomain> <42F14A9B.2050803@gmail.com>
In-Reply-To: <42F14A9B.2050803@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030507060600060706070109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030507060600060706070109
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Jiri Slaby napsal(a):

> Alan Cox napsal(a):
>
>>>> drivers/char/drm/gamma_dma.c
>>>> drivers/char/drm/gamma_drv.c
>>>>     
>>>
>>
>> Gamma is defunct certainly
>>  
>>
> Removes gamma sources, headers and pointers from Kconfig and Makefile.
>
> Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
>
> patch is here (about 70 KiB):
> http://www.fi.muni.cz/~xslaby/lnx/gamma.txt
>
Removes gamma line from Documentation/kernel-parameters.txt

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/Documentation/kernel-parameters.txt 
b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -497,8 +497,6 @@ running once the system is up.
                        Format: <port#>,<pad1>,<pad2>,<pad3>,<pad4>,<pad5>
                        See also Documentation/input/joystick-parport.txt

-       gamma=          [HW,DRM]
-
        gdth=           [HW,SCSI]
                        See header of drivers/scsi/gdth.c.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10



--------------030507060600060706070109
Content-Type: text/plain;
 name="gamma_doc_rm.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gamma_doc_rm.txt"

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -497,8 +497,6 @@ running once the system is up.
 			Format: <port#>,<pad1>,<pad2>,<pad3>,<pad4>,<pad5>
 			See also Documentation/input/joystick-parport.txt
 
-	gamma=		[HW,DRM]
-
 	gdth=		[HW,SCSI]
 			See header of drivers/scsi/gdth.c.
 

--------------030507060600060706070109--
