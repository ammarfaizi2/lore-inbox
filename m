Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280983AbRLDAfx>; Mon, 3 Dec 2001 19:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280838AbRLDAfe>; Mon, 3 Dec 2001 19:35:34 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:54510 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281046AbRLDAdz>; Mon, 3 Dec 2001 19:33:55 -0500
Date: Tue, 4 Dec 2001 00:33:50 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Steffen Persvold <sp@scali.no>, lkml <linux-kernel@vger.kernel.org>,
        nfs list <nfs@lists.sourceforge.net>, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: 2.4.9 kernel crash
Message-ID: <20011204003350.L2857@redhat.com>
In-Reply-To: <3C077FF8.AFBD8DB8@scali.no> <3C07E905.DF30E497@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C07E905.DF30E497@zip.com.au>; from akpm@zip.com.au on Fri, Nov 30, 2001 at 12:16:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 30, 2001 at 12:16:05PM -0800, Andrew Morton wrote:

> There was a bug in ext3 which was fixed around about the 2.4.9
> timeframe.  I don't know if the fix is present in that
> particular Red Hat kernel.  It was fixed in ext3 0.9.8.  The
> ext3 version number is displayed when you mount a filesystem.
> 
> The 0.9.8 changelog says:
> 
> - Fix an NFS oops when doing a local delete on an active, nfs-exported
>   file.
> 
> I never observed this bug - I think the fix came from Ted T'so.  I
> do not know whether the bug manifested itself as "busy inodes
> after unmount".  Perhaps Ted or Stephen can comment?

The NFS bug could present as "bit already cleared", but I don't think
I ever saw it leave busy inodes behind.

Cheers,
 Stephen
