Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264811AbUFGP6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264811AbUFGP6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUFGP6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:58:12 -0400
Received: from [141.156.69.115] ([141.156.69.115]:36747 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S264819AbUFGP5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:57:00 -0400
Message-ID: <40C4904A.2080903@infosciences.com>
Date: Mon, 07 Jun 2004 11:56:58 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Greg KH <greg@kroah.com>, Ian Abbott <abbotti@mev.co.uk>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
References: <40C08E6D.8080606@infosciences.com> <c9q8a6$hga$1@sea.gmane.org> <20040605001832.GA28502@kroah.com> <40C47972.8090703@infosciences.com> <Pine.LNX.4.53.0406071141090.10324@chaos>
In-Reply-To: <Pine.LNX.4.53.0406071141090.10324@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Mon, 7 Jun 2004, nardelli wrote:
> 
> 
>>Greg KH wrote:
>>
>>>On Fri, Jun 04, 2004 at 05:34:41PM +0100, Ian Abbott wrote:
>>>
>>>
>>>>On 04/06/2004 15:59, nardelli wrote:
> 
> [SNIPPED...]
> 
> 
>>>
>>>===== drivers/usb/serial/visor.c 1.114 vs edited =====
>>>--- 1.114/drivers/usb/serial/visor.c	Fri Jun  4 07:13:10 2004
>>>+++ edited/drivers/usb/serial/visor.c	Fri Jun  4 17:12:53 2004
>>
>>...
>>
>>Just curious - is there something special about 42?  Grepping wasn't
>>very useful, as numbers like this are scattered all over the place.
>>
>>
>>>+/* number of outstanding urbs to prevent userspace DoS from happening */
>>>+#define URB_UPPER_LIMIT	42
> 
> 
> See Hitchiker's Guide to the Galaxy. ;^
> 

LOL - I knew I shouldn't have asked :-)


-- 
Joe Nardelli
jnardelli@infosciences.com
