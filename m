Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129683AbQKFM6G>; Mon, 6 Nov 2000 07:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129670AbQKFM56>; Mon, 6 Nov 2000 07:57:58 -0500
Received: from zeus.kernel.org ([209.10.41.242]:11532 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129192AbQKFM5q>;
	Mon, 6 Nov 2000 07:57:46 -0500
Date: Mon, 6 Nov 2000 12:55:25 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Marco d'Itri" <md@Linux.IT>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Linux-2.4.0-test10
Message-ID: <20001106125525.E17728@redhat.com>
In-Reply-To: <E13qiR9-0008FT-00@the-village.bc.nu> <20001102171717.L1876@redhat.com> <20001104194937.E3423@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001104194937.E3423@wonderland.linux.it>; from md@Linux.IT on Sat, Nov 04, 2000 at 07:49:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 04, 2000 at 07:49:37PM +0100, Marco d'Itri wrote:
> On Nov 02, "Stephen C. Tweedie" <sct@redhat.com> wrote:
> 
>  >2.2 O_SYNC is actually broken too --- it doesn't sync all metadata (in
>  >particular, it doesn't update the inode), but I'd rather fix that for
>  >2.4 rather than change 2.2, as the main users of O_SYNC, databases,
>  >are writing to preallocated files anyway.
> What about fsync(2)? Will it update metadata too?

Yes --- fsync has never had that problem.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
