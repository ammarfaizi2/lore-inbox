Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266290AbUANXhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266315AbUANXe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:34:26 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:45732 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S265259AbUANXch
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:32:37 -0500
Message-ID: <4005D195.3010008@inp-net.eu.org>
Date: Thu, 15 Jan 2004 00:32:37 +0100
From: Raphael Rigo <raphael.rigo@inp-net.eu.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gsstark@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org> <87hdyyxjgl.fsf@stark.xeocode.com> <20040114225653.GA32704@codepoet.org>
In-Reply-To: <20040114225653.GA32704@codepoet.org>
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Wed Jan 14, 2004 at 05:18:34PM -0500, Greg Stark wrote:
> 
>>Jeff Garzik <jgarzik@pobox.com> writes:
>>
>>
>>>Intel ICH5
>>>
>>>Issue #2: Excessive interrupts are seen in some configurations.
>>
>>I guess I'm seeing this problem. I'm trying to get my P4P800 motherboard with
>>an ICH5 chipset working completely. So far I've been living without the cdrom
>>or DVD players. I see lots of other posts on linux-kernel about the same
>>problems:
> 
> 
> I have the same deal.  My offer to send Jeff a P4P800 motherboard
> to test with is still open....
> 
>  -Erik
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
One possible workaround it to enable both PATA and SATA drivers (using 
libata) and pass "ide2=noprobe ide3=noprobe" to kernel at boot.
More detailled answer can be found here : 
http://www.hentges.net/howtos/p4p800_deluxe.html
Regards,
Raphaël.
