Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265188AbUEMUTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbUEMUTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265194AbUEMURw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 16:17:52 -0400
Received: from zamok.crans.org ([138.231.136.6]:45231 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S264674AbUEMUQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 16:16:56 -0400
Message-ID: <40A3D79C.4030509@minas-morgul.org>
Date: Thu, 13 May 2004 22:16:28 +0200
From: Mathieu Segaud <matt@minas-morgul.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: eric.valette@free.fr, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2 : Hitting Num Lock kills keyboard
References: <40A3C951.9000501@free.fr>	<40A3CF97.5000405@free.fr> <20040513125750.59434a33.akpm@osdl.org>
In-Reply-To: <20040513125750.59434a33.akpm@osdl.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Eric Valette <eric.valette@free.fr> wrote:
>  
>
>>Eric Valette wrote:
>>    
>>
>>>Andrew,
>>>
>>>I tested 2.6.6-mm2 this afternoon and twice I totally lost my keyboard. 
>>>      
>>>
>>Well, I can reproduce it at will : I just need to hit the numlock key 
>>and keyboard is frozen.
>>    
>>
>
>Could you please do
>
>	patch -p1 -R -i bk-input.patch
>
>and see if it fixes it?
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm2/broken-out/bk-input.patch
>

It worked on my box, currently running 2.6.6-mm2

-- 
Mathieu Segaud

