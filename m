Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267610AbRGNKnW>; Sat, 14 Jul 2001 06:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbRGNKnM>; Sat, 14 Jul 2001 06:43:12 -0400
Received: from smtp-server1.cfl.rr.com ([65.32.2.68]:59903 "EHLO
	smtp-server1.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S267610AbRGNKm5>; Sat, 14 Jul 2001 06:42:57 -0400
Message-ID: <001101c10c51$bd6239e0$b6562341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "Andrew Morton" <andrewm@uow.edu.au>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> <3B4BD13F.6CC25B6F@uow.edu.au> <021801c10a03$62434540$e1de11cc@csihq.com> <3B4C729B.6352A443@uow.edu.au> <05c401c10ac1$0e81ad70$e1de11cc@csihq.com> <3B4D8B5D.E9530B60@uow.edu.au> <036e01c10b96$72ce57d0$e1de11cc@csihq.com> <111501c10ba3$664a1370$e1de11cc@csihq.com> <3B4F0273.1DF40F8E@uow.edu.au> <125101c10bc1$85eab630$e1de11cc@csihq.com> <20010713183800.J13419@redhat.com>
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246
Date: Sat, 14 Jul 2001 06:42:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only when I rebooted and fsck ran :-(

----- Original Message -----
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Mike Black" <mblack@csihq.com>
Cc: "Andrew Morton" <andrewm@uow.edu.au>; "linux-kernel@vger.kernel.or"
<linux-kernel@vger.kernel.org>; <ext2-devel@lists.sourceforge.net>
Sent: Friday, July 13, 2001 1:38 PM
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246


> Hi,
>
> On Fri, Jul 13, 2001 at 01:30:34PM -0400, Mike Black wrote:
> > Here's the oops:
> > Message on console:
> > yeti kernel: EXT3-fs error (device md(9,0)): ext3_new_inode: reserved
inode
> > or inode > inodes count - block_group = 0,inode=1
> >
> > Here line 575:
> >         J_ASSERT_JH(jh, !buffer_locked(jh2bh(jh)));
>
> Many thanks.  Were there any other log messages at all?
>
> Cheers,
>  Stephen

