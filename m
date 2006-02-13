Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWBMV4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWBMV4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWBMV4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:56:47 -0500
Received: from gold.veritas.com ([143.127.12.110]:32382 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964870AbWBMV4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:56:47 -0500
Date: Mon, 13 Feb 2006 21:57:31 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Linus Torvalds <torvalds@osdl.org>, William Irwin <wli@holomorphy.com>,
       Roland Dreier <rdreier@cisco.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [openib-general] Re: madvise MADV_DONTFORK/MADV_DOFORK
In-Reply-To: <20060213210906.GC13603@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
 <adar767133j.fsf@cisco.com> <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
 <Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com>
 <20060213210906.GC13603@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Feb 2006 21:56:46.0574 (UTC) FILETIME=[6242F8E0:01C630E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Michael S. Tsirkin wrote:
> 
> Like this then?

Almost.  I would still prefer madvise_vma to allow MADV_DONTFORK
on a VM_IO vma, even though it must prohibit MADV_DOFORK there.
But if Linus disagrees, of course ignore me.

Comments much better, thanks.  I didn't get your point about mlock'd
memory, but I'm content to believe you're thinking of an issue that
hasn't occurred to me.

Hugh
