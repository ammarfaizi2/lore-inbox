Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUIFU6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUIFU6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 16:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUIFU6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 16:58:12 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:40555 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S266311AbUIFU6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 16:58:08 -0400
Message-ID: <413CCF79.2080407@travellingkiwi.com>
Date: Mon, 06 Sep 2004 21:58:33 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
Subject: Re: New proposed DRM interface design
References: <20040904102914.B13149@infradead.org>	 <4139C8A3.6010603@tungstengraphics.com>	 <9e47339104090408362a356799@mail.gmail.com>	 <4139FEB4.3080303@tungstengraphics.com>	 <9e473391040904110354ba2593@mail.gmail.com>	 <1094386050.1081.33.camel@localhost.localdomain>	 <9e47339104090508052850b649@mail.gmail.com>	 <1094398257.1251.25.camel@localhost.localdomain>	 <9e47339104090514122ca3240a@mail.gmail.com>	 <1094417612.1936.5.camel@localhost.localdomain>	 <9e4733910409051511148d74f0@mail.gmail.com> <1094425142.2125.2.camel@localhost.localdomain>
In-Reply-To: <1094425142.2125.2.camel@localhost.localdomain>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Sul, 2004-09-05 at 23:11, Jon Smirl wrote:
>  
>
>>What is the advantage to continuing a development model where two
>>groups of programmers work independently, with little coordination on
>>two separate code bases trying to simultaneously control the same
>>piece of hardware? This is a continuous source of problems. Why can't
>>we fix the development model to stop this?
>>    
>>
>
>I don't see that as much of a problem. The mess arises from some simple
>lacks in the objects in kernel and the methods required to co-ordinate.
>Lots of drivers are written by a lot of people in the kernel and they
>work just fine. The ext3 authors don't spend their lives co-ordinating
>with SCSI driver authors, they just get the API right.
>
>  
>

Sorry, but I think that's (Possibly?) a really really bad & misleading 
example... Apples & Apples vs Chocolate & Milkshakes... The dual screen 
problem with DRM & fb is two drivers accessing (Sometimes) the same 
hardware. The ext3 vs SCSI is a filesystem, that sits on-top of a disk 
device that may just be SCSI.. Or IDE..

The fs -> SCSI interface is a logical one.

Unless you can have fb sitting on top of DRM of course... (I discount 
DRM on-top of fb, because of the D == Direct... No other reason :)...

Does it make sens to have fb ontop of DRM at all? Anyone?


regards
  Hamish.

