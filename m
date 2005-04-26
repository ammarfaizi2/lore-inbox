Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVDZOXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVDZOXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVDZOXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:23:12 -0400
Received: from [213.170.72.194] ([213.170.72.194]:53900 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261550AbVDZOW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:22:56 -0400
Message-ID: <426E4EBD.6070104@oktetlabs.ru>
Date: Tue, 26 Apr 2005 18:22:53 +0400
From: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
Cc: Ville Herva <v@iki.fi>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org>
In-Reply-To: <20050426141426.GC10833@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> I think I've wanted something like that for _years_ in unix.
> 
> It's an old, old idea, and I've often wondered why we haven't implemented it.
> 

I thought it is possible to rather easily to implement this on top
of non-transactional FS (albeit I didn't try) and there is no need
to overcomplicate an FS. Just implement a specialized user-space
library and utilize it.


-- 
Best regards, Artem B. Bityuckiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
