Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270336AbUJUIML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270336AbUJUIML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 04:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270481AbUJUIMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 04:12:10 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:57783 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S270459AbUJUILb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 04:11:31 -0400
Message-ID: <41776F2A.1080707@t-online.de>
Date: Thu, 21 Oct 2004 10:11:22 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.7, amd64: PS/2 Mouse detection doesn't work
References: <40F0E586.4040000@t-online.de> <20040711084208.GA1322@ucw.cz>	 <417660AE.4060408@t-online.de> <1098301207.12411.35.camel@localhost.localdomain>
In-Reply-To: <1098301207.12411.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: EAXQdOZHweHFJ7Wk80F6FmgUD+4H4vyffezpnLo7D2QmV7+TmY8Ygh
X-TOI-MSGID: 27b3e477-bf6a-4218-b7c9-5c2a2809939e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2004-10-20 at 13:57, Harald Dunkel wrote:
> 
>>Hi folks,
>>
>>Attached you can find an updated patch for 2.6.9.
> 
> 
> You need to handle the USB reset quirks for OHCI and also catch any
> escaped interrupts. It also seems you have to deal with UHCI (at least
> my E750x fixes arent sufficient with a keyboard on an EHCI hub)
> 

I am not a kernel developer. I just modified Vojtech's patch
for 2.6.9. His patch works for me since 2.6.7.

But it seems that UHCI _is_ handled, isn't it?


Regards

Harri
