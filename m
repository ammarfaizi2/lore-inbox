Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVKIRsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVKIRsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVKIRsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:48:50 -0500
Received: from [67.137.28.189] ([67.137.28.189]:47744 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1750729AbVKIRst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:48:49 -0500
Message-ID: <4372230B.3080002@wolfmountaingroup.com>
Date: Wed, 09 Nov 2005 09:25:47 -0700
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
References: <43720DAE.76F0.0078.0@novell.com>  <43722AFC.4040709@pobox.com> <1131558785.6540.34.camel@localhost.localdomain>
In-Reply-To: <1131558785.6540.34.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Mer, 2005-11-09 at 11:59 -0500, Jeff Garzik wrote:
>  
>
>>Honestly, just seeing all these code changes makes me think we really 
>>don't need it in the kernel.  How many "early" and "alternative" gadgets 
>>do we really need just for this thing?
>>    
>>
>
>I think it is clearly the case that the design is wrong. The existance
>of kgdb shows how putting the complex logic remotely on another system
>is not only a lot cleaner and simpler but can also provide more
>functionality and higher reliability.
>
>The presence of user mode linux and Xen also provide solutions to the
>usual concern about needing two systems, as will future hardware
>features.
>  
>

Not necessarily true with regard to having the functionality in the 
kernel, but for Linux, probably better for maintenance based on the social
issues.  I have MDB fully integrated in the kernel and I don't have all 
these problems.  It's just an update to the kdb hooks, patch, build and go.
Novell should probably just fork the kernel and start their own distro 
and dump the mainstream Linux.  They have the people and infrastructure
to support drivers and do just as good a job as LKML with the old 
NetWare group.  Novell was presented with MDB two years ago and opted
to build their own rather than go with ours.  I have been disappointed 
with the quality of what they have produced to date.

They should fork form Linux and understand that the Linux folks and 
their culture is totaly alien to Novell's culture.   They will never make
progress with the Linux folks and continued interactions will waste both 
groups time.  They have the talent and resources to preempt Linux
and do their own thing.  They need to just go and do it.

J


>Alan
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

