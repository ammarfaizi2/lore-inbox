Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbUKYDiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUKYDiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 22:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbUKYDiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 22:38:50 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:37137 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S262954AbUKYDir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 22:38:47 -0500
Message-ID: <41A55376.3010608@snapgear.com>
Date: Thu, 25 Nov 2004 13:37:26 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compound page overhaul
References: <41A49940.6030104@snapgear.com>  <20041122155434.758c6fff.akpm@osdl.org> <11948.1101130077@redhat.com> <29356.1101201515@redhat.com> <20041123081129.3e0121fd.akpm@osdl.org> <20041123171039.GK2714@holomorphy.com> <30282.1101319407@redhat.com>
In-Reply-To: <30282.1101319407@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Howells wrote:
> Greg Ungerer <gerg@snapgear.com>:
> 
>>The refcounting has been annoying me for a while, it just feels
>>wrong. It has been done that way for a very long time (since 2.4.0
>>IIRC). I am sure there was more to it back in the 2.4 but I don't
>>think we need to do it like this any more.
> 
> 
> It was like that in 2.4 also - where I first developed this arch and these mm
> changes. The refcount-on-free bug is there also. I don't know why no one else
> has hit it.
> 
> 
>>I don't have any problem with what David has done so far though
>>I need to test it more extensively first.
> 
> 
> That'd be great! :-)
> 
> I need to look at dumping my 2.4 arch & changes into the 2.4-uc kernels too.

That would be good :-)

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
