Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315423AbSE2S76>; Wed, 29 May 2002 14:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315429AbSE2S75>; Wed, 29 May 2002 14:59:57 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:5787 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315423AbSE2S74>;
	Wed, 29 May 2002 14:59:56 -0400
Date: Wed, 29 May 2002 11:59:15 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: Ben Greear <greearb@candelatech.com>
cc: Nivedita Singhvi <niv@us.ibm.com>, <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: how to get per-socket stats on udp rx buffer overflow?
In-Reply-To: <3CF4F421.1040908@candelatech.com>
Message-ID: <Pine.LNX.4.33.0205291149350.5686-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002, Ben Greear wrote:

> Integer increments are usually pretty cheap.  Considering
> accuracy is not absolutely needed (imho), then there is no
> need to lock or use special atomic increments.

Cool!

> So, I view the performance issue as not that big of a deal.  Space
> may be a bigger deal, and the /proc interface and/or IOCTLs to read
> the counters...

You could consider per-cpu interrupt/process context buckets
the way the current MIB counter increments are, if space isnt
an issue, although that might be overkill. 

> If/when I do implement, I'll be sure to make it a selectable option
> in the kernel config process...

Cool :).

> Ben
> 

thanks,
Nivedita

