Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265731AbRFXLIN>; Sun, 24 Jun 2001 07:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbRFXLID>; Sun, 24 Jun 2001 07:08:03 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:47851 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S265731AbRFXLHn>;
	Sun, 24 Jun 2001 07:07:43 -0400
Date: Sun, 24 Jun 2001 13:07:40 +0200 (CEST)
From: Seth Mos <knuffie@xs4all.nl>
To: Daniel Stone <daniel@sfarc.net>
cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] XFS in large Maildir
In-Reply-To: <20010624205252.A26659@kabuki.sfarc.net>
Message-ID: <Pine.BSI.4.10.10106241255490.12216-100000@xs4.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001, Daniel Stone wrote:

> On Sun, Jun 24, 2001 at 12:18:00PM +0200, Seth Mos wrote:
> > On Sun, 24 Jun 2001, Daniel Stone wrote:
> > 
> > > Hi guys,
> > > I've attached the ksymoops output from Linux 2.4.6-pre3-xfs (CVS tree from
> > > some point). I'll try an update now, but when I try to access stuff in
> > > ~/Maildir/netfilter/cur (~7k files in it), XFS just OOPSes. The OOPS I
> > > attached was from mutt, but it also successfully hangs ls, so I doubt it's a
> > > mutt bug.
> > 
> > Have you tried running xfs_repair -n on the filesystem to see if something
> > is wrong? Was the kernel compiled with 2.96-?? of 2.91.66?
> 
> I haven't tried anything on the filesystem yet, and it was compiled with
> Debian (sid aka unstable)'s 2.95.3 snapshot.

if you can run xfs_repair -n to see if it produces error output.
xfs_repair -n works on a mounted filesystem but does not change anything.

If you do see errors you need to unmount the fs and run xfs_repair and see
if you can reproduce the oops after that there must be other issues.

Can you also apt-get 2.95.4? I believe that one currently is in unstable.
Even if it is just to test for compiler differences.

Thanks
Seth

