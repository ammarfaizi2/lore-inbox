Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVDZPyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVDZPyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVDZPyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:54:04 -0400
Received: from [213.170.72.194] ([213.170.72.194]:6541 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261576AbVDZPvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:51:45 -0400
Message-ID: <426E638B.9070704@oktetlabs.ru>
Date: Tue, 26 Apr 2005 19:51:39 +0400
From: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       John Stoffel <john@stoffel.org>, Ville Herva <v@iki.fi>,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <17006.22498.394169.98413@smtp.charter.net> <1114528782.13568.8.camel@lade.trondhjem.org> <20050426154708.GC14297@mail.shareable.org>
In-Reply-To: <20050426154708.GC14297@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> The problem with making them exclusive locks is that you halt the
> system for the duration of the transaction.  If it's a big transaction
> such as updating 1000 files for a package update, that blocks a lot of
> programs for a long time, and it's not necessary.

Surely we'll anyway block others if we have a kernel-level transaction 
support?
What is the difference in which layer to block?

-- 
Best regards, Artem B. Bityuckiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
