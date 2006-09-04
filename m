Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWIDKSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWIDKSB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWIDKSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:18:01 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:63676 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751352AbWIDKSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:18:00 -0400
Message-ID: <44FBFEE9.4010201@student.ltu.se>
Date: Mon, 04 Sep 2006 12:24:41 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: akpm@osdl.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4-mm3 2/2] fs/xfs: Converting into generic boolean
References: <44F833C9.1000208@student.ltu.se> <20060904150241.I3335706@wobbly.melbourne.sgi.com>
In-Reply-To: <20060904150241.I3335706@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:

>On Fri, Sep 01, 2006 at 03:21:13PM +0200, Richard Knutsson wrote:
>  
>
>>From: Richard Knutsson <ricknu-0@student.ltu.se>
>>
>>Converting:
>>'B_FALSE' into 'false'
>>'B_TRUE'  into 'true'
>>'boolean_t' into 'bool'
>>    
>>
>
>Hmm, so your bool is better than the next guys bool[ean[_t]]? :)
>  
>
Well yes, because it is not "mine". ;)
It is, after all, just a typedef of the C99 _Bool-type.

>Seems like it'll be a few more days until the next cleanup patch
>to remove _that_, so we shouldn't go that path.
>
A generic boolean to an integer? And if Andrew toss that patch, this one 
will follow.
So what is wrong with this path?

>                                                 Since we do use
>the current boolean_t somewhat inconsistently in XFS, I'd say we
>should just toss the thing and use int.
>  
>
If _that_ is the problem, I am happy to help. Did not want to touch more 
then the already defined "booleans", because it seemed to scare some people.
After all, what interest me next most to a generic boolean, is using 
booleans when it obviously is a boolean.

>I took the earlier patch and completed it, switching over to int
>use in place of boolean_t in the few places it used - I'll merge
>that at some point, when its had enough testing.
>  
>
Is that set in stone? Or is there a chance to (in my opinion) improve 
the readability, by setting the variables to their real type.

>cheers.
>  
>
best regards


-- 
VGER BF report: H 0.117186
