Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280883AbRKTEF3>; Mon, 19 Nov 2001 23:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280890AbRKTEFS>; Mon, 19 Nov 2001 23:05:18 -0500
Received: from marine.sonic.net ([208.201.224.37]:27680 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S280883AbRKTEFH>;
	Mon, 19 Nov 2001 23:05:07 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Mon, 19 Nov 2001 20:05:03 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
Message-ID: <20011119200503.B10322@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0111192340500.4079-100000@imladris.surriel.com> <Pine.LNX.4.33.0111200344080.1395-100000@behemoth.ts.ray.fi> <20011119194354.A10322@thune.mrc-home.com> <E1661rR-0001Vl-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1661rR-0001Vl-00@localhost>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 07:46:13PM -0800, Ryan Cumming wrote:
> On November 19, 2001 19:43, you wrote:
> > What are unintented consequences for not removing it?
> >
> > I.e., backups.
> It already has the "Don't back me up" attribute set ('d'), and I've come 
> across absolutely no problems running my system with it lurking in my root 
> directory.

Which, as I understand it, only applies to dump for ext2fs.

Dump does not reliably work with live file systems with 2.4.x Linus
has even gone on record stating that he does not approve that approach, so
don't expect that to change.

What versions of gtar, star, find|cpio, amanda, or whatever, know how to
handle the `d' attribute?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
