Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTJ2Owk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 09:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbTJ2Owj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 09:52:39 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:64148 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S261644AbTJ2Owg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 09:52:36 -0500
Message-ID: <3F9FD42F.3080706@mainstreetsoftworks.com>
Date: Wed, 29 Oct 2003 09:52:31 -0500
From: Brad House <brad@mainstreetsoftworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross.alexander@uk.neceur.com
Cc: Brad House <brad@mcve.com>, linux-kernel@vger.kernel.org
Subject: Re: nforce2 stability on 2.6.0-test5 and 2.6.0-test9
References: <OFD0D30073.3921A657-ON80256DCE.004EDE5F-80256DCE.0050215F@uk.neceur.com>
In-Reply-To: <OFD0D30073.3921A657-ON80256DCE.004EDE5F-80256DCE.0050215F@uk.neceur.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting, I'll search through lkml for that.  The only thing
I can say is that we're not seeing that on nForce3 w/x86_64, which
is the only nforce mb I have access to, and it uses basically the
same driver.

-Brad

ross.alexander@uk.neceur.com wrote:
> Brad,
> 
> My problem is one of the infamous nforce2 hardlockups.  You don't get any
> kernel panic or anything that useful.  The system just locks up completely
> and has to be manually reset.
> 
> The problem is known to associate with IDE activity and is thought (as far
> as I know) to originate somewhere in the IDE driver.
> 
> Cheers,
> 
> Ross
> 
> ---------------------------------------------------------------------------------
> Ross Alexander                           "We demand clearly defined
> MIS - NEC Europe Limited            boundaries of uncertainty and
> Work ph: +44 20 8752 3394         doubt."
> 
> 
> 
> 
> Brad House <brad@mcve.com>
> 10/29/2003 02:13 PM
>  
>         To:     ross.alexander@uk.neceur.com
>         cc:     Brad House <brad_mssw@gentoo.org>, 
> linux-kernel@vger.kernel.org
>         Subject:        Re: nforce2 stability on 2.6.0-test5 and 
> 2.6.0-test9
> 
> 
> Hmm, interesting. The patches I submitted were strictly
> for IDE/ATA133 improvements, apparently your problems don't
> lie there.  I'd assume this was a kernel panic you had, any
> output available that would tell you where it paniced ?
> 
> -Brad
> 
> ross.alexander@uk.neceur.com wrote:
> 
>>Brad,
>>
>>I'm running an ASUS A7N8X Deluxe mobo (nforce2 chipset) and still
>>getting hardlockups.  I applied your patch but my system still locked
>>up after about a day.  However 2.6.0-test5 seems to be stable.  I have
>>had my system up for over three weeks with APIC and ACPI turned on.
>>
>>Just to let you know,
>>
>>Ross
>>
>>
> 
> ---------------------------------------------------------------------------------
> 
>>Ross Alexander                           "We demand clearly defined
>>MIS - NEC Europe Limited            boundaries of uncertainty and
>>Work ph: +44 20 8752 3394         doubt."
>>
> 
> 
> 
> 
> 
> 


-- 
-----------------------------
Brad House
Sr. Developer
Main Street Softworks, Inc.

brad@mainstreetsoftworks.com
(386) 462-9522 Ext. 112
-----------------------------

