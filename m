Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSGEJYs>; Fri, 5 Jul 2002 05:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSGEJYr>; Fri, 5 Jul 2002 05:24:47 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2459 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316213AbSGEJYr>; Fri, 5 Jul 2002 05:24:47 -0400
Date: Fri, 5 Jul 2002 08:59:17 +0100
From: Stephen Tweedie <sct@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020705085917.F27198@redhat.com>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au> <20020628215942.GA3679@pelks01.extern.uni-tuebingen.de> <20020702131314.B4711@redhat.com> <20020704220511.GA4728@pelks01.extern.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020704220511.GA4728@pelks01.extern.uni-tuebingen.de>; from kobras@tat.physik.uni-tuebingen.de on Fri, Jul 05, 2002 at 12:05:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 05, 2002 at 12:05:11AM +0200, Daniel Kobras
<kobras@tat.physik.uni-tuebingen.de> wrote:

> On Tue, Jul 02, 2002 at 01:13:14PM +0100, Stephen C. Tweedie wrote:
> > an fsync() on any file or directory on the filesystem will ensure that
> > all old transactions have completed, and a sync() will ensure that any
> > old transactions are at least on their way to disk.
> 
> With emphasis on 'on the filesystem', I suppose?  In other words, if we
> have an ext3 fs on /dev/hda1 mounted on /mnt, it is not sufficient to
> fsync("/dev/hda1") to flush the transactions, but fsync("/mnt") will do?
> (Excuse the sloppy notation.)

Right.

--Stephen
