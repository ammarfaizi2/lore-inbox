Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbSJTU67>; Sun, 20 Oct 2002 16:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJTU67>; Sun, 20 Oct 2002 16:58:59 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:42762 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261366AbSJTU66>;
	Sun, 20 Oct 2002 16:58:58 -0400
Message-ID: <3DB31A8E.7060103@mvista.com>
Date: Sun, 20 Oct 2002 16:05:18 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI driver for Linux, version 7
References: <Pine.NEB.4.44.0210191249240.28761-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Tue, 15 Oct 2002, Corey Minyard wrote:
>
>  
>
>>In the continuing saga of IPMI driver updates, here's another installment.
>>
>>More cleanups and bug fixes, some from Arjan van de Ven, and others from
>>myself. This fixes some problems with blocking operations while holding
>>a lock. It has an unfortunate interface change (but better now than
>>later), the lun field is removed from the IPMI message, and one is added
>>to the system interface address. It's a minor change, but it really
>>needed to be done to make things consistent. It's only released as a
>>patch to the v6 version and it applies cleanly to all kernel versions.
>> As usual, you can download the driver from my home page at
>>http://home.attbi.com/~minyard.
>>
>>-Corey
>>
>>PS - In case you don't know, IPMI is a standard for system management,
>>it provides ways to detect the managed devices in the system and sensors
>>attached to them.  You can get more information at
>>http://www.intel.com/design/servers/ipmi/spec.htm
>>    
>>
>
><--  snip  -->
>
>...
>Adopters Agreement:
>
>Before implementing the IPMI, IPMB or ICMB specifications, a royalty-free
>reciprocal patent license must be signed. Please follow the steps below to
>sign the IPMI Adopters Agreement:
>...
>·  Adopter hereby grants to the Promoters and to Fellow Adopters, and the
>   Promoters hereby grant to Adopter, a nonexclusive, royalty-free,
>   nontransferable, nonsublicenseable, worldwide license under its
>   Necessary Claims to make, have made, use, import, offer to sell and
>   sell products which comply with the Specification; provided that such
>   license shall not extend to features of a product which are not
>   required to comply with the Specification or for which there exists a
>   feasible, noninfringing alternative.
>...
>
><--  snip  -->
>
>
>Am I right that this makes it impossible to include an IPMI driver into
>the kernel (this isn't GPL-compatible)?
>
I do not read it so, but perhaps you are right.  I will ask.  I'm sure I 
will receive a resounding "maybe" as the answer.  I was working with 
people at Intel on this, and they had another driver they wanted to use 
for IPMI, and wanted to push it into the kernel, but it had some 
problems so I wrote this as a replacement.  So I don't think Intel sees 
it this way (at least those at Intel I was working with).

-Corey

