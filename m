Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVDFIdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVDFIdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 04:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVDFIdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 04:33:17 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.24]:3987 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262144AbVDFIbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 04:31:34 -0400
X-ME-UUID: 20050406083133383.5DAF11C00084@mwinf0708.wanadoo.fr
Message-ID: <42539E0C.7090306@innova-card.com>
Date: Wed, 06 Apr 2005 10:30:04 +0200
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: franck.bui-huu@innova-card.com
Organization: Innova Card
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BOOTMEM] bad physical address convertions.
References: <425240A2.6020504@innova-card.com> <1112731209.19430.135.camel@localhost>
In-Reply-To: <1112731209.19430.135.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>I suggest using something like discontigmem (or even sparsemem for that
>matter) to properly handles holes in your address space.
>
>  
>
I don't agree with you. First I don't see any advantages to use 
"discontigmem" just
because physical ram address doesn't start to 0. I would embed and run 
extra code
that is not needed for my case.
Secondly, even if you're right, code that uses "addr >> PAGE_SHIFT" are 
by-passing
mm api, that is somehow a hack....

Cheers.

                Franck

