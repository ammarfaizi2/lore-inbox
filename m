Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135800AbRAGIIn>; Sun, 7 Jan 2001 03:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135808AbRAGIIe>; Sun, 7 Jan 2001 03:08:34 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:9477
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S135800AbRAGIIV>; Sun, 7 Jan 2001 03:08:21 -0500
Date: Sun, 7 Jan 2001 21:08:18 +1300
From: Chris Wedgwood <cw@f00f.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010107210818.A2230@metastasis.f00f.org>
In-Reply-To: <20010107045346.B696@metastasis.f00f.org> <E14Evjb-0001Dk-00@the-village.bc.nu> <20010107050718.C696@metastasis.f00f.org> <m1r92fj10c.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1r92fj10c.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Jan 07, 2001 at 12:05:07AM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 12:05:07AM -0700, Eric W. Biederman wrote:

    Umm.  No.  The object of LFS stuff is so that programs that can't
    handle large files don't shoot themselves in the foot.  You don't
    need to pass O_LARGEFILE over the protocol and knfsd doesn't need
    to handle it.  But with out specifying O_LARGEFILE you should be
    limited to 2GB on 32bit systems.

THis means we limit all NFS file sizes to 32-bits unless we have
NFSv3? (I assume v3 is where the 64-bit file sizes comes from? or
does it predate that?)


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
