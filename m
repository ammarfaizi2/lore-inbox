Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287499AbRLaOs5>; Mon, 31 Dec 2001 09:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287529AbRLaOsq>; Mon, 31 Dec 2001 09:48:46 -0500
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:24052 "EHLO
	gintaras.vetrunge.lt.eu.org") by vger.kernel.org with ESMTP
	id <S287499AbRLaOsf>; Mon, 31 Dec 2001 09:48:35 -0500
Date: Mon, 31 Dec 2001 16:48:26 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: Why would a valid DVD show zero files on Linux?
Message-ID: <20011231144826.GA1541@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16L2G8-00050T-00@the-village.bc.nu> <3C307464.2253E26@obviously.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C307464.2253E26@obviously.com>
User-Agent: Mutt/1.3.24i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2001 at 09:21:24AM -0500, Bryce Nesbitt wrote:
> > The autodetection is working. Your DVD has a UDF file system on it and a
> > blank iso9660 one.
> 
> Understood.   However, why can't that combination "just work"?  Changing
> /etc/fstab every time I switch between sticking in a CD-ROM and DVD-ROM is not cool.
> Certainly that "other operating system" does not make me do that.

I used to have two lines in my /etc/fstab: one to mount /dev/cdrom on
/cdrom as iso9660, another to mount /dev/cdrom on /cdudf as udf.  Then
it's simply a matter of mount /cdrom or mount /cdudf.

Of course, that "other operating system" does not require you to
manually mount CD-ROMs at all.

Marius Gedminas
-- 
Thus spake the master programmer:
        "After three days without programming, life becomes meaningless."
                -- Geoffrey James, "The Tao of Programming"
