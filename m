Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWAPPue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWAPPue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWAPPue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:50:34 -0500
Received: from picard.linux.it ([213.254.12.146]:4301 "EHLO picard.linux.it")
	by vger.kernel.org with ESMTP id S1751044AbWAPPud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:50:33 -0500
Message-ID: <6142.83.103.117.254.1137426632.squirrel@picard.linux.it>
In-Reply-To: <20060116114805.GB12069@infradead.org>
References: <20060110235554.GA3527@inferi.kami.home>
    <20060110170037.4a614245.akpm@osdl.org>
    <20060115221458.GA3521@inferi.kami.home>
    <20060116094817.A8425113@wobbly.melbourne.sgi.com>
    <43CB6796.4040104@namesys.com> <20060116114805.GB12069@infradead.org>
Date: Mon, 16 Jan 2006 16:50:32 +0100 (CET)
Subject: Re: 2.6.15-mm3 bisection: git-xfs.patch makes reiserfs oops
From: "Mattia Dongili" <malattia@linux.it>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Hans Reiser" <reiser@namesys.com>, "Nathan Scott" <nathans@sgi.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, linux-xfs@oss.sgi.com,
       "Jeff Mahoney" <jeffm@suse.com>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, January 16, 2006 12:48 pm, Christoph Hellwig said:
> On Mon, Jan 16, 2006 at 01:29:58AM -0800, Hans Reiser wrote:
>> Thanks Nathan, Mattia, and Andrew.
>>
>> vs, can you or Jeff look at whether our buffer head inits are
>> sufficiently hardened by next Monday (I know that vs has a lot of mail
>> to catch up to)?  Jeff, if you have time before then, it would be nice
>> if you could handle it, I know hardening V3 is an interest of yours.
>
> Chris Mason just sent a patch to -fsdevel that initialized bh->b_private
> in reiserfs.  Mattia, I'll bounce you the patch privately, could you try
> to see if it helps?

It does help, as does Nathan's patch.
BTW: I'm testing it on -mm4 (I reproduced the same oops here)

Thanks
-- 
mattia
:wq!


