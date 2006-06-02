Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWFBWdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWFBWdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 18:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWFBWdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 18:33:15 -0400
Received: from wx-out-0102.google.com ([66.249.82.207]:59259 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932583AbWFBWdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 18:33:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=AaAvV3Hmw7PAcWY+SeDXI3j7Oc/AGSWkMFswnhPRhBk8CDDfE3A7/NNp9rrbd7Y/EBnMpce9QuIdMClt3GclnQt5MryGSL8NZt4rd1Vlt9ZN/1wB8VKJAdHarSawvfmrJA9ggsq25OA96WzKG+PiufE3IpRuqgeaDfuZwW60Yqc=
Message-ID: <986ed62e0606021533n4c8954eeifd71f97611a4c7f@mail.gmail.com>
Date: Fri, 2 Jun 2006 15:33:12 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060602205332.GA5022@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com>
	 <20060601183836.d318950e.akpm@osdl.org>
	 <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com>
	 <20060602142009.GA10236@elte.hu>
	 <986ed62e0606021101t6701d095ycd29c91885aaeec9@mail.gmail.com>
	 <20060602205332.GA5022@elte.hu>
X-Google-Sender-Auth: 85ed718a2a70be4b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/06, Ingo Molnar <mingo@elte.hu> wrote:
> does it get any better if you remove:
>
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/broken-out/lock-validator-floppyc-irq-release-fix.patch
>
> ?

I won't be able to check until later today. With the tracing patch
added (for figuring out the warning at boot time), my kernel is about
50-60K too large to fit on a 1.6MB floppy. I first need to see if I
can trim or modularize some fat from my kernel without affecting the
reproducibility of these bugs... (If all else fails, I'll probably add
a CD-RW drive to this box and boot kernels from that.)
-- 
-Barry K. Nathan <barryn@pobox.com>
