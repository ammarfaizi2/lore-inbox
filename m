Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130204AbQLSSLY>; Tue, 19 Dec 2000 13:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130346AbQLSSLO>; Tue, 19 Dec 2000 13:11:14 -0500
Received: from ns.caldera.de ([212.34.180.1]:50695 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130204AbQLSSK4>;
	Tue, 19 Dec 2000 13:10:56 -0500
Date: Tue, 19 Dec 2000 18:40:23 +0100
Message-Id: <200012191740.SAA31465@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: phillips@innominate.de (Daniel Phillips)
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3A3F904F.8FBC46A5@innominate.de>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A3F904F.8FBC46A5@innominate.de> you wrote:
>> I think the semantics of the filesystem specific ->flush and ->writepage
>> are not the same.
>> 
>> Is ok for filesystem specific writepage() code to sync other "physically
>> contiguous" dirty pages with reference to the one requested by
>> writepage() ?
>> 
>> If so, it can do the same job as the ->flush() idea we've discussing.
>
> Except that for ->writepage you don't have the option of *not* writing
> the specified page.

In current -test13pre you have.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
