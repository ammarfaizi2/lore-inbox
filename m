Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbWCOPxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbWCOPxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 10:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbWCOPxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 10:53:21 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:50271 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751652AbWCOPxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 10:53:20 -0500
Message-ID: <4418386B.9020102@watson.ibm.com>
Date: Wed, 15 Mar 2006 10:53:15 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch 2/9] Initialization
References: <1142296834.5858.3.camel@elinux04.optonline.net>	 <1142297101.5858.10.camel@elinux04.optonline.net>	 <1142418273.3021.10.camel@laptopd505.fenrus.org> <1142426256.5597.24.camel@localhost.localdomain>
In-Reply-To: <1142426256.5597.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Mer, 2006-03-15 at 11:24 +0100, Arjan van de Ven wrote:
>  
>
>>>+ * This program is free software; you can redistribute it and/or modify it
>>>+ * under the terms of version 2.1 of the GNU Lesser General Public License
>>>+ * as published by the Free Software Foundation.
>>>+ *
>>>      
>>>
>>LGPL inside the kernel doesn't make a whole lot of sense.... better make
>>it GPL.
>>    
>>
>
>When you combine an LGPL and GPL work you get a GPL work so yes it would
>be clearer to mark it GPL as that is what it became as it was merged,
>but perhaps to add a note stating where it can be obtained under other
>licenses for other projects.
>
>  
>
Thanks. The LGPL usage is a mistake in the core code....will change to GPL
everywhere except the  case below. There's no intent to have the kernel 
code available
under other licenses etc. so thats not a problem.

However, the confusion about what license to use for a header file that 
will need to be
included in a potentially non-GPL user application persists. The header file
    include/linux/taskstats.h, created in patch 9/9
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0603.1/1925.html

defines the user-kernel messaging interface and should probably continue 
to have LGPL,
just to be absolutely safe legally. I've not been following the legal 
twists too carefully so
its probably overkill.

--Shailabh






