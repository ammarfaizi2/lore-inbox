Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSL2X2p>; Sun, 29 Dec 2002 18:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSL2X2p>; Sun, 29 Dec 2002 18:28:45 -0500
Received: from franka.aracnet.com ([216.99.193.44]:62861 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262214AbSL2X2o>; Sun, 29 Dec 2002 18:28:44 -0500
Date: Sun, 29 Dec 2002 14:56:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Hellwig <hch@lst.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Bill Irwin <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove CONFIG_X86_NUMA
Message-ID: <78170000.1041202589@titus>
In-Reply-To: <20021229234051.A12535@lst.de>
References: <200212292239.gBTMdPJ12407@localhost.localdomain>
 <20021229234051.A12535@lst.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > It's only used to hide two entries in arch/i386/Kconfig.
>>
>> The patch looks good.  If it's OK to get rid of X86_NUMA, could you also
>> move  X86_NUMAQ under the subarch menu?
>
> I already wondered about that, but AFAIK a kernel with X86_NUMAQ set
> still boots on a PeeCee, so it's really an option, not a choice.

Nope, it won't boot on a PC - you're probably thinking of Summit,
which should. I think Bill had a patch to move NUMA-Q already ...
want to publish that one?

M.

