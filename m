Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161487AbWHDXwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161487AbWHDXwj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161493AbWHDXwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:52:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:56123 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161487AbWHDXwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:52:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Gmb/RFzbT95GdvXKAOODAl4weKRkYpuKqnwRY+lU63cOK6mWNNs2vxpKf4RsVV+DEpO/gOQlRuV52aJ+OP6aaz5tItIdPeahNY/iXDbRFgW/b5FffjC0AMt5i9JV5nqA9lkFikL0ej03l1oxcYuNbC+qhOeR+5l8Q5FRIx9PVxc=
Message-ID: <44D3DDD7.2010608@gmail.com>
Date: Sat, 05 Aug 2006 01:52:32 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, support@moxa.com.tw
Subject: Re: [RFC 1/2] Char: mxser, upgrade to 1.9.1
References: <we_have_too_much_work@hehe.blahblah> <20060730123150.883d9121.akpm@osdl.org>
In-Reply-To: <20060730123150.883d9121.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 29 Jul 2006 15:29:43 -0400
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> mxser, upgrade to 1.9.1
>>
>> Change driver according to original 1.9.1 moxa driver.
> 
> Where did these changes come from?  The Moxa website, perhaps?
> 
> Do we know what they do?  Have you been able to test it?

Ok. Bernard did not test it:
<cite>
In fact, due to distro version differences between mine and the one
installed on my friends linuxbox (I was running Mandriva 2006 with 2.6
kernel and he had a Knoppix system with 2.4 kernel), I did not had the
opportunity to check if the new version sent by Moxa support worked
before he disappeared.
But I dont see any reason it would not. Moxa guys have all the hardware
in their development departement to check their product drivers.

I just verified that 1.9.1 driver source could be compiled under kernel
2.6. and so did it.
</cite>

So, what do you expect me to do, Andrew? Add just pci_ids + its config with no 
int->ulong conversion + writing ~UART_IER_THRI to the port?

thanks,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
