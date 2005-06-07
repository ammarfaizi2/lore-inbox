Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVFGP47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVFGP47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVFGP47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:56:59 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:55520 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261899AbVFGP4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 11:56:43 -0400
X-ME-UUID: 20050607155640717.AF17A1C00575@mwinf0301.wanadoo.fr
Message-ID: <42A5C2F9.3010809@worldonline.fr>
Date: Tue, 07 Jun 2005 17:53:29 +0200
From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; fr-FR; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: fr-fr, en-us
MIME-Version: 1.0
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
References: <42A0D88E.7070406@pobox.com>	<20050603163843.1cf5045d.akpm@osdl.org>	<42A0F05A.8010901@ens-lyon.org> <20050603182125.3735f0c7.akpm@osdl.org> <42A5B27F.60204@ens-lyon.org>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi Brice,

    What is your X configuration ? The default parameters are ok for a 
VideoRam parameter up to 32MB. Could you check two things, please ?
    - First, could you set VideoRam to 32MB in your X conf.
    - Second, could you set it to 64MB and use a voffset=64 parameter 
for intelfb.

Thanks
Sylvain

Brice Goglin a écrit:

>Andrew Morton a écrit :
>  
>
>>Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>>
>>    
>>
>>>Andrew Morton a écrit :
>>>
>>>      
>>>
>>>>Lots of USB problems, quite a few input problems.  fbdev, ACPI, ATAPI.  All
>>>>the usual suspects.
>>>>
>>>>Subject: intelfb crash on i845
>>>>Subject: Re: [Linux-fbdev-devel] intelfb crash on i845
>>>>        
>>>>
>>>These two entries seem to be the same one, from me.
>>>Sylvain Meyer was working on it. And I've recently seen some patches
>>>      
>>>
>>>from him on the mm-commit list. I didn't have time to test them but I
>>    
>>
>>>should be able to try next week (especially if a new -mm is released
>>>soon).
>>>      
>>>
>
>Hi Andrew,
>
>I just tried with rc6-mm1 and the problem is still present:
>when the onboard video memory is set to 1MB in the BIOS, switching from
>X to VT1 gives a dirty framebuffer console (no text, just wrong colors).
>Setting memory to 8MB in the BIOS makes all this work.
>
>Brice
>
>  
>



