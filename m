Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136686AbRAMMeA>; Sat, 13 Jan 2001 07:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136717AbRAMMdv>; Sat, 13 Jan 2001 07:33:51 -0500
Received: from james.kalifornia.com ([208.179.0.2]:18267 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S136686AbRAMMdr>; Sat, 13 Jan 2001 07:33:47 -0500
Message-ID: <3A604B26.53EC029F@linux.com>
Date: Sat, 13 Jan 2001 04:33:42 -0800
From: David Ford <david@linux.com>
Reply-To: david+validemail@kalifornia.com
Organization: Talon Technology, Intl.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: linux-kernel@vger.kernel.org
Subject: shmem or swapfs? was: [Patch] make shm filesystem part configurable
In-Reply-To: <m366jj20si.fsf@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:

> Hi,
>
> The appended patch (additional to my read/write support patch) makes
> the shm filesystem configurable and renames it to the more sensible
> name swapfs. Since the fs type "shm" is quite established with 2.4 I
> register that name also.

Now...is this shared memory or swap?  If it's swap, why is it different than a swapfile?  If you are intending the shmem be called swapfs, I
personally thing that it'll cause a significant amount of confusion.

-d


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
