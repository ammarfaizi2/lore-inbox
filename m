Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287688AbRLaXiS>; Mon, 31 Dec 2001 18:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287690AbRLaXiI>; Mon, 31 Dec 2001 18:38:08 -0500
Received: from bexfield.research.canon.com.au ([203.12.172.125]:40515 "HELO
	b.mx.canon.com.au") by vger.kernel.org with SMTP id <S287688AbRLaXiB>;
	Mon, 31 Dec 2001 18:38:01 -0500
Date: Tue, 1 Jan 2002 10:37:53 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Bryce Nesbitt <bryce@obviously.com>
Cc: linux-kernel@vger.kernel.org, Lionel Bouton <Lionel.Bouton@free.fr>,
        Andries.Brouwer@cwi.nl
Subject: Re: Why would a valid DVD show zero files on Linux?
Message-ID: <20020101103753.A13046@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <E16L2G8-00050T-00@the-village.bc.nu> <3C307464.2253E26@obviously.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C307464.2253E26@obviously.com>; from bryce@obviously.com on Mon, Dec 31, 2001 at 09:21:24AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2001 at 09:21:24AM -0500, Bryce Nesbitt <bryce@obviously.com> wrote:
| Alan Cox wrote:
| > The autodetection is working. Your DVD has a UDF file system on it and a
| > blank iso9660 one.
| Understood.   However, why can't that combination "just work"?  Changing
| /etc/fstab every time I switch between sticking in a CD-ROM and DVD-ROM is not cool.
| Certainly that "other operating system" does not make me do that.

I do this via autofs, and just say /mnt/dvd when I want UDF and /mnt/cdrom
when I want a CDROM. It does depend on having my eyes open when I stick
the medium in the drive...

Of course, this merely bypasses the autodetection.
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

Ed Campbell's <ed@Tekelex.Com> pointers for long trips:
7. Be prepared to have at least 1 flat, 2 electrical problems and a
   broken chain. Maybe a broken clutch cable too. The best prevention
   is to be able to fix it on the spot, only things you can't fix
   will break according to the law.
