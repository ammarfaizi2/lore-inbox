Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVCUW1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVCUW1I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVCUWYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:24:47 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:18850 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S261947AbVCUWXI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:23:08 -0500
X-Spam-Report: SA TESTS
 -1.7 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
Message-ID: <423F496C.10004@twisted-brains.org>
Date: Mon, 21 Mar 2005 23:23:40 +0100
From: Mws <mws@twisted-brains.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2/2] SquashFS
References: <20050314170653.1ed105eb.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <200503211908.46602.mws@twisted-brains.org> <20050321185418.GC1390@elf.ucw.cz>
In-Reply-To: <20050321185418.GC1390@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>>>>Also, this filesystem seems to do the same thing as cramfs.  We'd need to
>>>>>understand in some detail what advantages squashfs has over cramfs to
>>>>>justify merging it.  Again, that is something which is appropriate to the
>>>>>changelog for patch 1/1.
>>>>>          
>>>>>
>>>>Well, probably Phillip can answer this better than me, but the main 
>>>>differences that affect end users (and that is why we are using SquashFS 
>>>>right now) are:
>>>>                          CRAMFS          SquashFS
>>>>
>>>>Max File Size               16Mb               4Gb
>>>>Max Filesystem Size        256Mb              4Gb?
>>>>        
>>>>
>>>So we are replacing severely-limited cramfs with also-limited
>>>squashfs... For live DVDs etc 4Gb filesystem size limit will hurt for
>>>sure, and 4Gb file size limit will hurt, too. Can those be fixed?
>>>      
>>>
>
>...
>  
>
>>but if there is a contribution from the outside - it is not taken "as is" and maybe fixed up, which
>>should be nearly possible in the same time like analysing and commenting the code - it ends up
>>in having less supported hardware. 
>>
>>imho if a hardware company does indeed provide us with opensource drivers, we should take these
>>things as a gift, not as a "not coding guide a'like" intrusion which
>>has to be defeated.
>>    
>>
>
>Remember that horse in Troja? It was a gift, too.
>									Pavel
>
>  
>
of course there had been a horse in troja., but thinking like that 
nowadays is a bit incorrect - don't you agree?

code is reviewed normally - thats what i told before and i stated as 
good feature - but there is no serious reason
to blame every code to have potential "trojan horses" inside and to 
reject it.

regards
marcel
