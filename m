Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVKMW0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVKMW0u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVKMW0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:26:50 -0500
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:55995 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1750767AbVKMW0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:26:49 -0500
Message-ID: <4377BD8A.9070404@kolumbus.fi>
Date: Mon, 14 Nov 2005 00:26:18 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: 7eggert@gmx.de, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Jason <dravet@hotmail.com>,
       Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
References: <58c2Z-8jG-23@gated-at.bofh.it> <E1EbNir-0006ky-DP@be1.lrz> <4377BA19.2060600@gmail.com>
In-Reply-To: <4377BA19.2060600@gmail.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP1|June 19, 2005) at 14.11.2005 00:26:35,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP1|June
 19, 2005) at 14.11.2005 00:27:26,
	Serialize complete at 14.11.2005 00:27:26
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:

>Bodo Eggert wrote:
>  
>
>>Antonino A. Daplas <adaplas@gmail.com> wrote:
>>
>>    
>>
>>>+++ b/drivers/video/console/vgacon.c
>>>+#define VGA_FONTWIDTH       8   /* VGA does not support fontwidths != 8 */
>>>      
>>>
>>This is not true, VGA cards do support fontwidth=9, but the ninth column
>>    
>>
>
>Yes.  What it should mean is that vgacon does not support fontwidths != 8.
>
>  
>
I think vgacon doesn't touch the 8/9 pixel setting, so  the fonts are hw 
extended to 9 pixels by VGA in many modes.

--Mika

