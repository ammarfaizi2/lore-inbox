Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266854AbSKOWO1>; Fri, 15 Nov 2002 17:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266853AbSKOWO0>; Fri, 15 Nov 2002 17:14:26 -0500
Received: from franka.aracnet.com ([216.99.193.44]:35775 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266852AbSKOWO0>; Fri, 15 Nov 2002 17:14:26 -0500
Date: Fri, 15 Nov 2002 14:18:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Khoa Huynh <khoa@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, kniht@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-kernel-owner@vger.kernel.org, mailing-lists@digitaleric.net
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <466918934.1037369899@[10.10.2.3]>
In-Reply-To: <OFDE7F70CA.ED358C3F-ON85256C72.00740082@pok.ibm.com>
References: <OFDE7F70CA.ED358C3F-ON85256C72.00740082@pok.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If we have to use a 2-level component list, then I'd prefer we
> do the following:
> 
> Category = 2.5-linus, 2.5-ac, 2.5-mm, etc.
> Component = something like
>       MM-Page allocator
>       MM-Slab allocator
>       MM-NUMA
>       MM-MTTR
>       MM-Others
>       FileSys-devfs
>       FileSys-ext2
>       FileSys-ext3
>       and so on...

No. That ends up with 10 billion items all in one drop down list,
which is a pain in the butt to use.

> The above approach does not require any coding changes in Bugzilla
> and is therefore preferrable.

The current fix doesn't require coding changes either, and was trivial
to implement. A long term solution should be done properly, by the
addition of a tree field.

M.

