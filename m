Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbUKNLQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbUKNLQs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 06:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbUKNLQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 06:16:47 -0500
Received: from pop.gmx.net ([213.165.64.20]:4832 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261285AbUKNLQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 06:16:02 -0500
X-Authenticated: #427522
Message-ID: <41973E70.6030400@gmx.de>
Date: Sun, 14 Nov 2004 12:16:00 +0100
From: Mathis Ahrens <Mathis.Ahrens@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.3) Gecko/20041028
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
CC: Luc Saillard <luc@saillard.org>,
       Gergely Nagy <algernon@bonehunter.rulez.org>,
       linux-kernel@vger.kernel.org
Subject: Re: pwc driver status?
References: <200411132134.52872.lkml@kcore.org> <1100380178.16772.23.camel@melkor> <20041113211816.GC22949@sd291.sivit.org> <200411141111.38951.lkml@kcore.org>
In-Reply-To: <200411141111.38951.lkml@kcore.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:

>On Saturday 13 November 2004 22:18, Luc Saillard wrote:
>  
>
>>On Sat, Nov 13, 2004 at 10:09:38PM +0100, Gergely Nagy wrote:
>>    
>>
>>>>Unfortunately, upgrading is not an option right now for other
>>>>reasons...
>>>>        
>>>>
>>>That's a pity... because there is no 2.4 version of Luc's driver as far
>>>as I know :(
>>>      
>>>
>>I don't use a 2.4 kernel, so i can produce patch for older kernel, but i'll
>>not test them. If someone want a 2.4 kernel tell me, and i'll try to mande
>>a patch using difftools. I prefer to add features like v4l2, than
>>supporting and testing old kernel (or writing documentation).
>>    
>>
>
>Understandable. I'll look into getting the other box upgraded, tho the owner 
>of it is kinda reluctant to do so.
>  
>
I don't think you have to.
The latest release from nemosoft is not in the kernel anymore, but still
online:

    http://www.smcc.demon.nl/webcam/

It is supposed to still work with 2.4

>  
>
>>>>Is this driver also supporting the Logitech Quickcam for Notebooks? I
>>>>found some references that the 'official' one used to do that, but I
>>>>can't find much docs...
>>>>        
>>>>
>>>As far as I know, yes. The source code seems to indicate the same.
>>>      
>>>
>>If the old driver supports, mine too (minor some very old webcam).
>>    
>>
>
>Ok, good to know. Would be nice tho to have some actual 'confirmation' of this 
>fact before I run off to spend money ;p
>
 From the philips.txt included in the above reference:

    As of this moment, the following cameras are supported:
    [...]
     * Logitech QuickCam Notebook Pro
    [...]

(Note the 'Pro', this might be important!)

And as Luc said, once you upgrade to 2.6 you will have the same
support with his driver.

Cheers,
Mathis
