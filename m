Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVFWA6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVFWA6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVFWA6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:58:31 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59852 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261939AbVFWA6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:58:25 -0400
Message-ID: <42BA092A.7090408@us.ibm.com>
Date: Wed, 22 Jun 2005 17:58:18 -0700
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Gerrit Huizenga <gh@us.ibm.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (kexec/kdump)
References: <20050621132204.1b57b6ba.akpm@osdl.org>	<E1Dkpn1-0006va-00@w-gerrit.beaverton.ibm.com> <20050621140441.53513a7a.akpm@osdl.org>
In-Reply-To: <20050621140441.53513a7a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Gerrit Huizenga <gh@us.ibm.com> wrote:
>  
>
>>Kexec/kdump has a chance of working reliably.
>>    
>>
>
>IOW: Kexec/kdump has a chance of not working reliably.
>
>Worried.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
I understand your concerns based on the device shutdown issues but these 
are not fundamental design problems that we can not solve. We should be 
able to fix them either through generic solutions to a class of devices 
or one of kind for special devices. As you know we are engaging in those 
discussions and providing fixes.

I think all the alternatives out there are less reliable than Kdump 
based on the design. Vendors are currently shipping other solutions 
since they didn't have any better alternatives until now. The existing 
solutions in the two major distro's doesn't work lot of times. I don't 
know what percentage of times they work as i only get involved when they 
don't work, but i can certainly tell you they don't work many a times. 
It is very embarrassing to tell the customer sorry we couldn't get dump 
can you try reproducing the problem again.  At least two major distros 
expressed interest in replacing their current solutions with kdump once 
it matures. As you are well aware we are doing testing with as many 
configurations as we can to iron out the bugs. Hope this addresses some 
of your concerns.

