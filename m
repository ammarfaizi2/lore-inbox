Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSFEKrw>; Wed, 5 Jun 2002 06:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSFEKrv>; Wed, 5 Jun 2002 06:47:51 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:44962
	"EHLO awak") by vger.kernel.org with ESMTP id <S315370AbSFEKrt> convert rfc822-to-8bit;
	Wed, 5 Jun 2002 06:47:49 -0400
Subject: Re: [rfc] "laptop mode"
From: Xavier Bestel <xavier.bestel@free.fr>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFDEA79.2980BF8D@zip.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Jun 2002 12:47:38 +0200
Message-Id: <1023274058.10560.117.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 05/06/2002 à 12:39, Andrew Morton a écrit :
> Xavier Bestel wrote:
> > 
> > Le mer 05/06/2002 à 01:43, Andrew Morton a écrit :
> > 
> > > Also, it has been suggested that the feature become more fully-fleshed,
> > > to support desktops with one disk spun down, etc.  It's not really
> > > rocket science to do that - the `struct backing_dev_info' gives
> > > a specific communication channel between the high-level VFS code and
> > > the request queue.  But that would require significantly more surgery
> > > against the writeback code, so I'm fishing for requirements here.  If
> > > the current (simple) patch is sufficient then, well, it is sufficient.
> > 
> > Have per-disk laptop-mode, so that some user-mode proggy (e.g. hotplug)
> > could decide what to do.
> 
> But why?

e.g. not mess with cdroms, autoalimented disks, some mp3-players seen as
usb-storage, whatever.

I just realized your patch was partly ide-specific, perhaps what I said
doesn't apply ?

