Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268935AbTBWUky>; Sun, 23 Feb 2003 15:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268943AbTBWUky>; Sun, 23 Feb 2003 15:40:54 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16876 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268935AbTBWUkx>; Sun, 23 Feb 2003 15:40:53 -0500
Date: Sun, 23 Feb 2003 12:50:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <16920000.1046033458@[10.10.2.4]>
In-Reply-To: <1046031687.2140.32.camel@bip.localdomain.fake>
References: <E18moa2-0005cP-00@w-gerrit2>
 <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
 <20030223082036.GI10411@holomorphy.com> <b3b6oa$bsj$1@penguin.transmeta.com>
 <1046031687.2140.32.camel@bip.localdomain.fake>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And the baroque instruction encoding on the x86 is actually a _good_
>> thing: it's a rather dense encoding, which means that you win on icache. 
>> It's a bit hard to decode, but who cares? Existing chips do well at
>> decoding, and thanks to the icache win they tend to perform better - and
>> they load faster too (which is important - you can make your CPU have
>> big caches, but _nothing_ saves you from the cold-cache costs). 
> 
> Next step: hardware gzip ?

They did that already ... IBM were demonstrating such a thing a couple of
years ago. Don't see it helping with icache though, as it unpacks between
memory and the processory, IIRC.

M.

