Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVKCL61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVKCL61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 06:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVKCL60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 06:58:26 -0500
Received: from mail.ncipher.com ([82.108.130.24]:34035 "EHLO mail.ncipher.com")
	by vger.kernel.org with ESMTP id S1750884AbVKCL60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 06:58:26 -0500
Message-ID: <4369FB5B.3050602@f0rmula.com>
Date: Thu, 03 Nov 2005 11:58:19 +0000
From: James Hansen <linux-kernel-list@f0rmula.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Trouble unloading a module..
References: <43664B31.3000305@f0rmula.com>	 <1130919119.2826.5.camel@laptopd505.fenrus.org>	 <4368AD58.6050809@f0rmula.com> <1130935171.2826.10.camel@laptopd505.fenrus.org>
In-Reply-To: <1130935171.2826.10.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update:

Just tried the driver with a 2.6.14 and it doesn't suffer the same 
problem.  As it looks to be doing what is required to unregister the 
chrdev, I'm loath to suggest it, but could this be a bug in the 2.6.8 
kernel?

Just a thought, so please shoot me down if I'm completly wrong :)

Cheers,

James


Arjan van de Ven wrote:

>On Wed, 2005-11-02 at 12:13 +0000, James Hansen wrote:
>  
>
>>I was thinking that there may have been a common issue that would allow 
>>a driver oops the kernel if not unloaded properly.  Obviously not.
>>
>>Thanks for any advice, it's much appreciated.
>>    
>>
>
>static struct pci_device_id nfp_pci_tbl[] __devinitdata = {
>
>you probably don't want that __devinitdata there....
>
>
>
>
>.
>
>  
>

