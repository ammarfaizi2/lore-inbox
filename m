Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285316AbRLSPBc>; Wed, 19 Dec 2001 10:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285318AbRLSPBW>; Wed, 19 Dec 2001 10:01:22 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:24334 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285316AbRLSPBC>; Wed, 19 Dec 2001 10:01:02 -0500
Date: Wed, 19 Dec 2001 18:01:00 +0300
From: Oleg Drokin <green@namesys.com>
To: Masaru Kawashima <masaruk@gol.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, chris@suse.de
Subject: Re: [reiserfs-list] reiserfs remount problem (Re: Linux 2.4.17-rc2)
Message-ID: <20011219180100.A28971@namesys.com>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva> <20011219230812.049c2c5c.masaruk@gol.com> <20011219172644.A28692@namesys.com> <20011219235203.322a02e3.masaruk@gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011219235203.322a02e3.masaruk@gol.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Dec 19, 2001 at 11:52:03PM +0900, Masaru Kawashima wrote:

> > > > - Reiserfs fixes				(Oleg Drokin/Chris Mason)
> > > There is still reiserfs remount problem with 2.4.17-rc2.
> > Hmmm.
> > Few things needs to be verified:
> > Is your reiserfs root partition 3.5 or 3.6 format? (can be checked in /proc/fs/reiserfs/.../version
> It's 3.6 format.
>   # cat /proc/fs/reiserfs/*/version
>   new format      with checks off
Hm. You said you are running 2.4.17-rc2, this is output from older kernel.
Or do you mean it is only 2.4.17-rc2 that cannot remount root read-write?

> I've tried reiserfsck with booting from spare root partition
> formatted with ext3.  But there was no errors.
Hm.

> > Is your root partition big?
> Yes.  It's 85GB.  And it's on a software raid (raid0) partition.
Ok, I still want the metadata from this partition (read man on debugreiserfsck on -p option),
and tell me you reiserfsutils version.

Also were there any reiserfs specific error messages prior to the oops?

Bye,
    Oleg
