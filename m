Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265351AbUFRQjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUFRQjq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUFRQjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:39:45 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:62081 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265351AbUFRQje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:39:34 -0400
Message-ID: <40D31ADA.3080204@blue-labs.org>
Date: Fri, 18 Jun 2004 12:39:54 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Iptables-1.2.9/10 compile failure with linux 2.6.7 headers
References: <200406181611.37890.andrew@walrond.org> <40D313DC.7000202@blue-labs.org> <200406181721.47968.andrew@walrond.org>
In-Reply-To: <200406181721.47968.andrew@walrond.org>
Content-Type: multipart/mixed;
 boundary="------------080805040507060109060808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080805040507060109060808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The current linux libc headers package is much more frequently updated 
and closely matches released kernels.  LLH is a sanitized linux headers 
package and is currently based on 2.6.6 headers.

Yes you can build iptables on 2.6.6 for a 2.6.7 kernel.  I have built 
iptables once or twice a year and built kernels once or twice a week.  
Iptables continues to work fine.

David

Andrew Walrond wrote:

>Hi David,
>
>On Friday 18 Jun 2004 17:10, David Ford wrote:
>  
>
>>Iptables should be using linux-libc-headers headers instead of kernel
>>headers.
>>    
>>
>
>Is this acquired knowledge, or new Netfilter policy?
>How dependant are the iptables tools on the specifc kernel running?
>
>Ie
>Can I build iptables for use on 2.6.7 kernel with 2.6.6 linux-libc-headers? 
>(probably)
>
>But could I build iptables for 2.6.7 kernel with 2.4.20 linux-libc-headers? 
>(probably not?)
>
>The INSTALL file states specifically to use 
>KERNEL_DIR=<<where-you-built-your-kernel>>
>
>Andrew
>  
>

--------------080805040507060109060808
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


--------------080805040507060109060808--
