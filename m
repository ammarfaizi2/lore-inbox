Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264071AbRFXKxb>; Sun, 24 Jun 2001 06:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264080AbRFXKxU>; Sun, 24 Jun 2001 06:53:20 -0400
Received: from [203.36.158.121] ([203.36.158.121]:4110 "EHLO
	piro.kabuki.sfarc.net") by vger.kernel.org with ESMTP
	id <S264071AbRFXKxE>; Sun, 24 Jun 2001 06:53:04 -0400
Date: Sun, 24 Jun 2001 20:52:53 +1000
From: Daniel Stone <daniel@sfarc.net>
To: Seth Mos <knuffie@xs4all.nl>
Cc: Daniel Stone <daniel@sfarc.net>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: [OOPS] XFS in large Maildir
Message-ID: <20010624205252.A26659@kabuki.sfarc.net>
Mail-Followup-To: Seth Mos <knuffie@xs4all.nl>,
	Daniel Stone <daniel@sfarc.net>, linux-xfs@oss.sgi.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSI.4.10.10106241216500.12216-100000@xs4.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSI.4.10.10106241216500.12216-100000@xs4.xs4all.nl>
User-Agent: Mutt/1.3.18i
Organisation: Sadly lacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2001 at 12:18:00PM +0200, Seth Mos wrote:
> On Sun, 24 Jun 2001, Daniel Stone wrote:
> 
> > Hi guys,
> > I've attached the ksymoops output from Linux 2.4.6-pre3-xfs (CVS tree from
> > some point). I'll try an update now, but when I try to access stuff in
> > ~/Maildir/netfilter/cur (~7k files in it), XFS just OOPSes. The OOPS I
> > attached was from mutt, but it also successfully hangs ls, so I doubt it's a
> > mutt bug.
> 
> Have you tried running xfs_repair -n on the filesystem to see if something
> is wrong? Was the kernel compiled with 2.96-?? of 2.91.66?

I haven't tried anything on the filesystem yet, and it was compiled with
Debian (sid aka unstable)'s 2.95.3 snapshot.

-- 
Daniel Stone						     <daniel@sfarc.net>
<Nuke> "can NE1 help me aim nuclear weaponz????? /MSG ME!!"
