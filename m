Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKDUtu>; Sat, 4 Nov 2000 15:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbQKDUtj>; Sat, 4 Nov 2000 15:49:39 -0500
Received: from spock.linux.it ([151.99.137.27]:49400 "HELO spock.linux.it")
	by vger.kernel.org with SMTP id <S129057AbQKDUtg>;
	Sat, 4 Nov 2000 15:49:36 -0500
Date: Sat, 4 Nov 2000 19:49:37 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Linux-2.4.0-test10
Message-ID: <20001104194937.E3423@wonderland.linux.it>
In-Reply-To: <E13qiR9-0008FT-00@the-village.bc.nu> <20001102171717.L1876@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001102171717.L1876@redhat.com>; from sct@redhat.com on Thu, Nov 02, 2000 at 05:17:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 02, "Stephen C. Tweedie" <sct@redhat.com> wrote:

 >2.2 O_SYNC is actually broken too --- it doesn't sync all metadata (in
 >particular, it doesn't update the inode), but I'd rather fix that for
 >2.4 rather than change 2.2, as the main users of O_SYNC, databases,
 >are writing to preallocated files anyway.
What about fsync(2)? Will it update metadata too?

-- 
ciao,
Marco


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
