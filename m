Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286893AbSBRUav>; Mon, 18 Feb 2002 15:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287306AbSBRUam>; Mon, 18 Feb 2002 15:30:42 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:24965 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S287408AbSBRUa3>;
	Mon, 18 Feb 2002 15:30:29 -0500
Subject: Re: 2.4.18-pre9-mjc2 compile errors
From: Michael Cohen <me@ohdarn.net>
To: linux-kernel@vger.kernel.org
Cc: root@deathstar.prodigy.com
In-Reply-To: <Pine.LNX.4.21.0202181322530.12110-200000@deathstar.prodigy.com>
In-Reply-To: <Pine.LNX.4.21.0202181322530.12110-200000@deathstar.prodigy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 18 Feb 2002 15:30:24 -0500
Message-Id: <1014064227.18406.1.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-18 at 13:25, root@deathstar.prodigy.com wrote:
> filemap.c: In function `__find_page_nolock':
> filemap.c:404: structure has no member named `next_hash'
> make[2]: *** [filemap.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/mm'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/usr/src/linux/mm'
> make: *** [_dir_mm] Error 2

There was a fix posted to lkml earlier, though I'd say that likely if
you can't fix this, you don't need to run this kernel. try looking at
lkml.  Next version will have it fixed, however. =)

------
Michael Cohen
OhDarn.net


