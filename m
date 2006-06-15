Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWFOLSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWFOLSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWFOLSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:18:23 -0400
Received: from cool.dworf.com ([193.189.190.81]:1640 "EHLO cool.dworf.com")
	by vger.kernel.org with ESMTP id S1030201AbWFOLSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:18:23 -0400
Message-ID: <449141F6.3090902@dworf.com>
Date: Thu, 15 Jun 2006 13:18:14 +0200
From: David Osojnik <david@dworf.com>
Reply-To: david@dworf.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: bad command responsiveness Proliant DL 585
References: <448FC1CE.9090108@dworf.com>	 <1150278161.7994.13.camel@Homer.TheSimpsons.net> <449060EE.60608@dworf.com>	 <1150353862.8097.61.camel@Homer.TheSimpsons.net> <44910E5B.50704@dworf.com> <1150358450.8638.12.camel@Homer.TheSimpsons.net>
In-Reply-To: <1150358450.8638.12.camel@Homer.TheSimpsons.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well i tired cfq,anticipatory,deadline,no-op schedulers/elevators with
atime but none worked the only difference is when I use noatime and
nodiratime

could this be an kernel problem?

David

Mike Galbraith wrote:

>On Thu, 2006-06-15 at 09:38 +0200, David Osojnik wrote:
>  
>
>>Hello,
>>
>>IT Works perfect when setting noatime,nodiratime on the partition!!
>>    
>>
>
>That's good to hear... sort of.
>  
>
>>can i try anything else? what does this actually mean?
>>    
>>
>
>Besides having a constipated journal sucks rocks? ;-)  Dunno.  You could
>try a different elevator as a shot in the dark - eliminate something.
>
>	-Mike
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
