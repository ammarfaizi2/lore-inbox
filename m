Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSFPSnT>; Sun, 16 Jun 2002 14:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316523AbSFPSnS>; Sun, 16 Jun 2002 14:43:18 -0400
Received: from [195.63.194.11] ([195.63.194.11]:21516 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316519AbSFPSnO> convert rfc822-to-8bit; Sun, 16 Jun 2002 14:43:14 -0400
Message-ID: <3D0CDC33.9050109@evision-ventures.com>
Date: Sun, 16 Jun 2002 20:42:59 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Peter Osterlund <petero2@telia.com>, Patrick Mochel <mochel@osdl.org>,
       Tobias Diedrich <ranma@gmx.at>,
       Alessandro Suardi <alessandro.suardi@oracle.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
References: <Pine.LNX.4.44.0206161115230.3316-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Linus Torvalds napisa³:
> 
> On 16 Jun 2002, Peter Osterlund wrote:
> 
>>Sure, with an unpatched 2.5.21 kernel, bringing up eth0 fails during
>>boot. Tobias Diedrich posted a one-line patch that fixes this problem
>>for me:
> 
> 
> Ok, that looks correct to me. Good.
> 
> 
>>All tests I have done so far with 2.5.21 based kernels produce an oops
>>at shutdown, which makes the machine hang instead of rebooting or
>>powering off.
> 
> 
> This is an IDE one - the IDE driver puts a device that it never got.

Adam J. Richter provided me already to "ture" sollution, which
is moving the management of devices entierly away out from
IDE code to the generic part. However I...

> I'll do a 2.5.22 (with Tobias' fix too).


... would be glad to release them based on 2.5.22, since
this would avoid some work synchronization
problems.

