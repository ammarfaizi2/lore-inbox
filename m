Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSJ2UEd>; Tue, 29 Oct 2002 15:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSJ2UEc>; Tue, 29 Oct 2002 15:04:32 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:43748 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262322AbSJ2UEb>; Tue, 29 Oct 2002 15:04:31 -0500
Date: Tue, 29 Oct 2002 20:11:24 +0000
From: Stephen Tweedie <sct@redhat.com>
To: David Fries <dfries@mail.win.org>, Stephen Tweedie <sct@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 dies without inodes
Message-ID: <20021029201124.GA13192@redhat.com>
References: <200209261355.g8QDtRg16986@sisko.scot.redhat.com> <20021029190029.GA27062@spacedout.fries.net> <20021029191453.GL28982@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021029191453.GL28982@clusterfs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 29, 2002 at 12:14:53PM -0700, Andreas Dilger <adilger@clusterfs.com> wrote:
> On Oct 29, 2002  13:00 -0600, David Fries wrote:
> > I'm runnig 2.4.19 and Debian (but I compile my own kernel from the
> > sources).  ext3 is forcing the block device to be read only when I run
> > out of inodes, and the only way out is reboot (that I could tell).
> > This is wrose than a good deal of kernel panics I've had.  Is
> > 2.4.20prewhatever any better with reguard to this error?
 
> Yes, this is fixed in more recent kernels.  Separate patches are also
> available if you want to stick with 2.4.19 for whatever reason.
> Stephen posted a URL for them a couple of times.

   http://people.redhat.com/sct/patches/ext3-2.4/for-2.4.19/all-in-one.patch

Cheers,
 Stephen
