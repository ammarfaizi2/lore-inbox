Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281030AbRKGWwt>; Wed, 7 Nov 2001 17:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281040AbRKGWwk>; Wed, 7 Nov 2001 17:52:40 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:13822
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281030AbRKGWwg>; Wed, 7 Nov 2001 17:52:36 -0500
Date: Wed, 7 Nov 2001 14:52:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107145229.A560@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E161Y87-00052r-00@the-village.bc.nu>, <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk> <3BE99650.70AF640E@zip.com.au>, <3BE99650.70AF640E@zip.com.au> <20011107133301.C20245@mikef-linux.matchmail.com> <3BE9AF15.50524856@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE9AF15.50524856@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 02:00:53PM -0800, Andrew Morton wrote:
> Mike Fedyk wrote:
> > 
> > I have a switch "data=journal" that ext2 will choke on when I boot into an
> > ext2 only kernel.
> > 
> > Is there another way to change the journaling mode besides modifying
> > /etc/fstab?
> 
> Try  adding `rootflags=data=journal' to your kernel boot
> commandline.
>

Oh, JOY!

adding that line to an ext2 only kernel will make it kernel panic when it
tries to mount root because it doesn't understand the option!

Mike
