Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287612AbSASWZT>; Sat, 19 Jan 2002 17:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287539AbSASWZJ>; Sat, 19 Jan 2002 17:25:09 -0500
Received: from unthought.net ([212.97.129.24]:31915 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S287537AbSASWY4>;
	Sat, 19 Jan 2002 17:24:56 -0500
Date: Sat, 19 Jan 2002 23:24:55 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Ville Herva <vherva@twilight.cs.hut.fi>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
Message-ID: <20020119232455.D12692@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Ville Herva <vherva@niksula.cs.hut.fi>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <3C477B7F.22875.11D4078A@localhost> <Pine.GSO.4.21.0201180546310.296-100000@weyl.math.psu.edu> <3C488E84.A1453ED2@zip.com.au> <20020119184259.GE135220@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20020119184259.GE135220@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Sat, Jan 19, 2002 at 08:43:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 08:43:00PM +0200, Ville Herva wrote:
> Alexander Viro wrote:
> > 
> > Merged: Per-process namespaces, late-boot cleanups.
> > Ready: switch to ->get_super() as primary file_system_type method.
> > Ready: ->getattr() handling and changes of ->setattr()/->permission()
> > prototypes.
> > Pending: proper UFS fixes, ext2 cleanups and locking
> > changes.
> > Pending: per-mountpoint read-only, union-mounts and unionfs.
> > Pending: lifting limitations on mount(2)
> > In progress: killing kdev_t for block devices (switch to struct block_device *)
> > Started: UMSDOS rewrite (the damn thing blocks struct inode trimming)
> > Planned: new mount API.
> 
> All this seems very neat. One question: what about forced umount / forced
> remount readonly stuff? Any plans on that?
> 

That would be *very* nice indeed.  Even if it was only for things like NFS
and SMBFS.

And even if it is unsafe - it's a lot better to be able to say "screw those
pending writes", than to have to say "screw the pending writes by rebooting the
system".

Just my 0.02 Euro

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
