Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310912AbSCHPbo>; Fri, 8 Mar 2002 10:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310913AbSCHPbe>; Fri, 8 Mar 2002 10:31:34 -0500
Received: from ns1.fast.net.uk ([212.42.162.2]:6404 "EHLO t2.fast.net.uk")
	by vger.kernel.org with ESMTP id <S310912AbSCHPbU>;
	Fri, 8 Mar 2002 10:31:20 -0500
Message-ID: <3C88D930.2080308@htec.demon.co.uk>
Date: Fri, 08 Mar 2002 15:30:56 +0000
From: Christopher Quinn <cq@htec.demon.co.uk>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interprocess shared memory .... but file backed?
In-Reply-To: <E16jMMJ-0006V3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>However as far as I can tell this is anonymous memory only.
>>Are there any options if one initially maps a disk file via 
>>mmap (in particular MAP_PRIVATE) for sharing that vm, such 
>>
> 
> well MAP_PRIVATE is "dont share" so not with that 8)
> Use MAP_SHARED and you'll get what you want
> 
> 

Certainly true! But MAP_SHARED gives uncontrolled flush of 
dirty data - so that's out for me. I only want 'privacy' to 
extend to the right to make changes permanent at my own 
discretion.

Chris Q.


-- 
rgrds,
Chris Quinn

