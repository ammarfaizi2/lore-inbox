Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130390AbRBCROy>; Sat, 3 Feb 2001 12:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130244AbRBCROo>; Sat, 3 Feb 2001 12:14:44 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:5895 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130417AbRBCROi>; Sat, 3 Feb 2001 12:14:38 -0500
Date: Sat, 3 Feb 2001 17:14:20 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@redhat.com>
cc: Hans Reiser <reiser@namesys.com>, Chris Mason <mason@suse.com>,
        Jan Kasprzak <kas@informatics.muni.cz>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <200102022213.f12MDCR27812@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.30.0102031713060.14268-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Alan Cox wrote:

> if [ -e /bin/rpm ]; then
>         X=`rpm -q gcc`
>         if [ "$X" = "gcc-2.96-54" ]; then
>                 echo "*** GCC 2.96-54 will miscompile Reiserfs. Please update your compiler"
>                 echo "See http://www.redhat.com/support/errata/RHBA-2000-132.html"
>                 exit 255
>         fi
> fi

 -a "$CC" = "gcc"

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
