Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281087AbRKGXim>; Wed, 7 Nov 2001 18:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281094AbRKGXic>; Wed, 7 Nov 2001 18:38:32 -0500
Received: from marine.sonic.net ([208.201.224.37]:21316 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S281087AbRKGXiT>;
	Wed, 7 Nov 2001 18:38:19 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 7 Nov 2001 15:38:05 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107153805.B27157@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <E161Y87-00052r-00@the-village.bc.nu>, <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk> <3BE99650.70AF640E@zip.com.au>, <3BE99650.70AF640E@zip.com.au> <20011107133301.C20245@mikef-linux.matchmail.com> <3BE9AF15.50524856@zip.com.au> <20011107145229.A560@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011107145229.A560@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 02:52:29PM -0800, Mike Fedyk wrote:
> On Wed, Nov 07, 2001 at 02:00:53PM -0800, Andrew Morton wrote:
> > Try  adding `rootflags=data=journal' to your kernel boot
> > commandline.
> 
> adding that line to an ext2 only kernel will make it kernel panic when it
> tries to mount root because it doesn't understand the option!


So set that option only for ext3 enabled kernels.  If you're using lilo,
instead of using a global append= setting, use a local one for that ext3
kernel, and leave it off for the ext2-only kernel.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
