Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135726AbRDSV4q>; Thu, 19 Apr 2001 17:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135728AbRDSV4g>; Thu, 19 Apr 2001 17:56:36 -0400
Received: from feral.com ([192.67.166.1]:27662 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S135726AbRDSV4T>;
	Thu, 19 Apr 2001 17:56:19 -0400
Date: Thu, 19 Apr 2001 14:56:15 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: "Brian J. Watson" <Brian.J.Watson@compaq.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: active after unmount?
In-Reply-To: <3ADF5DCB.EEADD4E0@compaq.com>
Message-ID: <Pine.BSF.4.21.0104191454390.81926-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Brian J. Watson wrote:

> > Unmounting a SCSI disk device succeeded, and yielded:
> > 
> > Red Hat Linux release 6.2 (Zoot)
> > Kernel 2.4.3 on a 2-processor i686
> > 
> > chico login: VFS: Busy inodes after unmount. Self-destruct in 5 seconds. Have
> > a nice day...
> > 
> 
> 
> This message comes out of kill_super(). I would guess that somebody's
> mismanaging VFS refcounts, but there's not enough info here to diagnose the
> problem. What filesystem are you using? Is this reproducible? What do you have
> to do between mounting and unmounting to reproduce the problem?

>>>>>>ext2<<<<<<, haven't reproduced it yet, on a 2x686 256MB memory,
SCSI midlayer default, with 2.4.3.

-matt



