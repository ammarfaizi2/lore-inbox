Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265741AbRFXLcX>; Sun, 24 Jun 2001 07:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265742AbRFXLcN>; Sun, 24 Jun 2001 07:32:13 -0400
Received: from [203.36.158.121] ([203.36.158.121]:23566 "EHLO
	piro.kabuki.sfarc.net") by vger.kernel.org with ESMTP
	id <S265741AbRFXLb7>; Sun, 24 Jun 2001 07:31:59 -0400
Date: Sun, 24 Jun 2001 21:31:51 +1000
From: Daniel Stone <daniel@sfarc.net>
To: Seth Mos <knuffie@xs4all.nl>
Cc: Daniel Stone <daniel@sfarc.net>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: [OOPS] XFS in large Maildir
Message-ID: <20010624213151.A27190@kabuki.sfarc.net>
Mail-Followup-To: Seth Mos <knuffie@xs4all.nl>,
	Daniel Stone <daniel@sfarc.net>, linux-xfs@oss.sgi.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSI.4.10.10106241255490.12216-100000@xs4.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSI.4.10.10106241255490.12216-100000@xs4.xs4all.nl>
User-Agent: Mutt/1.3.18i
Organisation: Sadly lacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2001 at 01:07:40PM +0200, Seth Mos wrote:
> On Sun, 24 Jun 2001, Daniel Stone wrote:
> 
> > On Sun, Jun 24, 2001 at 12:18:00PM +0200, Seth Mos wrote:
> > > On Sun, 24 Jun 2001, Daniel Stone wrote:
> > > 
> > > > Hi guys,
> > > > I've attached the ksymoops output from Linux 2.4.6-pre3-xfs (CVS tree from
> > > > some point). I'll try an update now, but when I try to access stuff in
> > > > ~/Maildir/netfilter/cur (~7k files in it), XFS just OOPSes. The OOPS I
> > > > attached was from mutt, but it also successfully hangs ls, so I doubt it's a
> > > > mutt bug.
> > > 
> > > Have you tried running xfs_repair -n on the filesystem to see if something
> > > is wrong? Was the kernel compiled with 2.96-?? of 2.91.66?
> > 
> > I haven't tried anything on the filesystem yet, and it was compiled with
> > Debian (sid aka unstable)'s 2.95.3 snapshot.
> 
> if you can run xfs_repair -n to see if it produces error output.
> xfs_repair -n works on a mounted filesystem but does not change anything.
> 
> If you do see errors you need to unmount the fs and run xfs_repair and see
> if you can reproduce the oops after that there must be other issues.
> 
> Can you also apt-get 2.95.4? I believe that one currently is in unstable.
> Even if it is just to test for compiler differences.

Er, it's the latest from unstable, whichever one that happens to be.

-- 
Daniel Stone						     <daniel@sfarc.net>
<Nuke> "can NE1 help me aim nuclear weaponz????? /MSG ME!!"
