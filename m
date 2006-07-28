Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751981AbWG1Ieq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbWG1Ieq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWG1Ieq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:34:46 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:27938 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751981AbWG1Iep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:34:45 -0400
Date: Fri, 28 Jul 2006 02:34:41 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Can we ignore errors in mcelog if the server is running fine
In-reply-to: <fa.9M8mPetEI5HZ8L2RMGPhKPm3gJA@ifi.uio.no>
To: Handle X <xhandle@gmail.com>
Cc: Vikas Kedia <kedia.vikas@gmail.com>, linux-kernel@vger.kernel.org
Message-id: <44C9CC21.9040609@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.5uWgnVpIOBN4Pb1aWwNzF8P2OA0@ifi.uio.no>
 <fa.9M8mPetEI5HZ8L2RMGPhKPm3gJA@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle X wrote:
> On 7/27/06, Robert Hancock <hancockr@shaw.ca> wrote:
>> Vikas Kedia wrote:
>> > The server seems to be running fine. A. can I ignore the following
>> > mcelog errors ? B. If not what should i do to stop the server from
>> > reporting mcelog errors.
>>
>> Looks like data cache ECC errors, meaning the CPU 0 is faulty.
>> Eventually if it's not replaced there will likely be some uncorrectable
>> errors and the system will likely crash.
> 
> I am facing similar, but different errors.
> 
> [root@turyxsrv ~]# mcelog
> MCE 0
> HARDWARE ERROR. This is *NOT* a software problem!
> Please contact your hardware vendor
> CPU 1 4 northbridge TSC 89a560bb249
> ADDR 1dfa49690
>  Northbridge Chipkill ECC error
>  Chipkill ECC syndrome = 2021
>       bit46 = corrected ecc error
>  bus error 'local node response, request didn't time out
>      generic read mem transaction
>      memory access, level generic'
> STATUS 9410c00020080a13 MCGSTATUS 0

> Repeats whenever I do any kind of operations...
> How severe is ChipKill errors? Should I consider throwing away CPU 1
> and get another one.

That sounds to me more like some of the RAM attached to CPU1 is bad..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

