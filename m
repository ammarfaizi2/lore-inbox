Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUHGXYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUHGXYw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUHGXYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:24:51 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:45539 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264085AbUHGXYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:24:21 -0400
Message-ID: <41156516.5080409@blue-labs.org>
Date: Sat, 07 Aug 2004 19:26:14 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hda: dma_timer_expiry: dma status == 0x24
References: <41152B61.90702@blue-labs.org> <1091915230.19077.11.camel@localhost.localdomain>
In-Reply-To: <1091915230.19077.11.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------050207090005070900000608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050207090005070900000608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

1. yes it recovers after about 20 seconds of machine stall, then does it 
again in a minute or two (using cdroms), or many minutes elsewise.
2. haven't had a chance to try with acpi=off, turning off acpi broke 
things for me a while back
3. haven't tested 2.4 (it didn't do this several kernels back), don't 
have any other operating systems

It's also worth noting that this timeout is severely aggravated by using 
my DVD and CD drives on hdc and hdd respectively.

David

Alan Cox wrote:

>On Sad, 2004-08-07 at 20:20, David Ford wrote:
>  
>
>>My desktop is experiencing issues with DMA lately.  This has been going 
>>on with the 2.6.8-rcX releases IIRC.  I'm currently on rc3.  The 
>>hardware is all brand new.
>>    
>>
>
>1. Does it recover after the timeout/lost irq
>2. Does it occur with acpi=off
>3. Have you tested say 2.4 or "otherOS" on it ?
>  
>

--------------050207090005070900000608
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------050207090005070900000608--
