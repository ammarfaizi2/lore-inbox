Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270656AbUJUBJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270656AbUJUBJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270655AbUJUBJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:09:13 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:39598 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270520AbUJUBI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:08:59 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Kgtnf/YyhCohaunKWRz+Gubb5QCtrtniLMOmbUJMAVN7ywqUA4DGMjgVFAExpwAjrZsO9lG/dvOy5JzE64XV2ab0/t4DXZXQL24cXjfAmpNedaK3TjvmbploDEHRJDrZrHLBjdw23UGKf/be5nUEBYpLGAT0Xp6O5ksQEIBfSqA
Message-ID: <9e4733910410201808c0796c8@mail.gmail.com>
Date: Wed, 20 Oct 2004 21:08:57 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Timothy Miller <miller@techsource.com>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4176E08B.2050706@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4176E08B.2050706@techsource.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have heard a lot of complaints from embedded people about having few
choices for graphics chips. Many of the low end chips from ATI/NVidia
are no longer in production and you are forced into buying more chip
than you want. You should ask about this on embedded developer lists.

For the new X servers you have to have hardware alpha blending.
Another important feature is accelerated drawing to off-screen
buffers. Also, DMA command queues help a lot with parallelizing
drawing.

If you implement VGA you will be able to boot and work in any x86
system without writing any code other than the BIOS.

-- 
Jon Smirl
jonsmirl@gmail.com
