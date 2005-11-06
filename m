Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVKFMoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVKFMoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 07:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVKFMoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 07:44:20 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:60653 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750744AbVKFMoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 07:44:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uUL/WVqbBAaBdg2G4VNG47GNC7k+SdJ6UY2Yx3AMeu++bLL0oFNGZrYb50M1vpEMM3k5PJx0HoJVcRxHTU006XjZBUwIP3W8Crhn3+Qfw1JPj4fVEF1VTFMVsflc+U8yBr2KeLAIlSyO2CPmTNLFwXJsFbF15yCkSMWbztEPVJ4=
Message-ID: <436DFA93.8070002@gmail.com>
Date: Sun, 06 Nov 2005 20:44:03 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/video/: possible cleanups
References: <20051106005026.GE3668@stusta.de> <436D9AF3.8040008@pol.net> <20051106111743.GA3847@stusta.de>
In-Reply-To: <20051106111743.GA3847@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Nov 06, 2005 at 01:56:03PM +0800, Antonino A. Daplas wrote:
>> Adrian Bunk wrote:
>>>
>>> --- linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c.old	2005-11-06 00:31:15.000000000 +0100
>>> +++ linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c	2005-11-06 00:31:30.000000000 +0100
>>> @@ -17,6 +17,8 @@
>>>  #include <asm/uaccess.h>
>>>  #include <asm/io.h>
>>>  
>>> +#include "fbcon.h"
>> I don't think softcursor needs anything in fbcon.h. The rest looks okay.
> 
> fbcon.h contains the function prototype for soft_cursor().

Ahh, you're right.  I forgot that I moved it to the console directory.

Tony

