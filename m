Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVD0Ngs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVD0Ngs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVD0Ngs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:36:48 -0400
Received: from one.firstfloor.org ([213.235.205.2]:16352 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261312AbVD0Ngp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:36:45 -0400
To: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
Cc: Ville Herva <v@iki.fi>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jamie@shareable.org
Subject: Re: filesystem transactions API
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
	<OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com>
	<20050426134629.GU16169@viasys.com>
	<20050426141426.GC10833@mail.shareable.org>
	<426E4EBD.6070104@oktetlabs.ru>
From: Andi Kleen <ak@muc.de>
Date: Wed, 27 Apr 2005 15:36:43 +0200
In-Reply-To: <426E4EBD.6070104@oktetlabs.ru> (Artem B. Bityuckiy's message
 of "Tue, 26 Apr 2005 18:22:53 +0400")
Message-ID: <m1ll74xrx0.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Artem B. Bityuckiy" <dedekind@oktetlabs.ru> writes:

> Jamie Lokier wrote:
>> I think I've wanted something like that for _years_ in unix.
>> It's an old, old idea, and I've often wondered why we haven't
>> implemented it.
>>
>
> I thought it is possible to rather easily to implement this on top
> of non-transactional FS (albeit I didn't try) and there is no need
> to overcomplicate an FS. Just implement a specialized user-space
> library and utilize it.

Yes it is. e.g. newer sleepycat DB has a nice library for this.
It should be somewhere on your distribution.

-Andi
