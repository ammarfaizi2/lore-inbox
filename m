Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264968AbSJ3Xc5>; Wed, 30 Oct 2002 18:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSJ3Xc5>; Wed, 30 Oct 2002 18:32:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:54941 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265091AbSJ3Xcy>; Wed, 30 Oct 2002 18:32:54 -0500
Message-ID: <3DC06CAE.8040806@us.ibm.com>
Date: Wed, 30 Oct 2002 15:35:10 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] use asm-generic/topology.h
References: <3DC056C2.4070609@us.ibm.com> <20021030233107.GB4820@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> Hi Matt,
> 
> 
>>use_generic_topology.patch
>>
>>This patch changes ppc64 & alpha to use the generic topology.h for the 
>>non-NUMA case rather than redefining the same macros.  It is much easier 
>>to maintain one set of generic non-NUMA macros than several.
> 
> 
> Looks good from the ppc64 perspective.
> 
> Anton

Glad to have the positive feedback.  It doesn't really change how 
anything works, just eliminates duplicate code and makes modifying the 
generic behavior simpler.

Anyone that works with alpha want to verify that I haven't inadvertently 
hosed your topology file?

Cheers!

-Matt

