Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131057AbQKXOT2>; Fri, 24 Nov 2000 09:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130911AbQKXOTW>; Fri, 24 Nov 2000 09:19:22 -0500
Received: from zeus.kernel.org ([209.10.41.242]:64267 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S131008AbQKXNnh>;
        Fri, 24 Nov 2000 08:43:37 -0500
Date: Fri, 24 Nov 2000 13:11:16 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Michael Marxmeier <mike@marxmeier.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, CMA <cma@mclink.it>,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: e2fs performance as function of block size
Message-ID: <20001124131116.C10362@redhat.com>
In-Reply-To: <E13yNlM-0005Q3-00@the-village.bc.nu> <3A1C487C.30BDFE9F@marxmeier.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A1C487C.30BDFE9F@marxmeier.com>; from mike@marxmeier.com on Wed, Nov 22, 2000 at 11:28:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 22, 2000 at 11:28:12PM +0100, Michael Marxmeier wrote:
> 
> If the files get somewhat bigger (eg. > 1G) having a bigger block
> size also greatly reduces the ext2 overhead. Especially fsync() 
> used to be really bad on big file but choosing a bigger block
> size changed a lot.

2.4 fsync should be better, but still dependent on file size.  The
O_SYNC patches I posted the other day give you an fsync which is
independent of file size.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
