Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263130AbREaSNj>; Thu, 31 May 2001 14:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbREaSN3>; Thu, 31 May 2001 14:13:29 -0400
Received: from [213.96.124.18] ([213.96.124.18]:14069 "HELO dardhal")
	by vger.kernel.org with SMTP id <S263130AbREaSNW>;
	Thu, 31 May 2001 14:13:22 -0400
Date: Thu, 31 May 2001 20:13:49 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jldomingo@crosswinds.net>
To: CML2 <linux-kernel@vger.kernel.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com, laughing@shared-source.org
Subject: Re: Configure.help is complete
Message-ID: <20010531201349.B1877@dardhal.mired.net>
Mail-Followup-To: CML2 <linux-kernel@vger.kernel.org>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com,
	laughing@shared-source.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010531132454.A8361@thyrsus.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 31 May 2001, at 13:24:54 -0400,
Eric S. Raymond wrote:

> It gives me great pleasure to announce that the Configure.help master
> file is now complete with respect to 2.4.5.  Every single one of the
> 2699 configuration symbols actually used in the 2.4.5 codebase's C
> source files or Makefiles now has an entry in Configure.help.
> 
Would it be great to have a similar documentation for those hundreds of
"files" under /proc ?. Something like:

/proc/sys/dev/raid/speed_limit_min

Subsystem: RAID
Module:    md.o
Configuration Option: Multi-device support (RAID and LVM) -> Multiple
devices driver support (RAID and LVM) -> RAID support
Type: positive integer ¿32-bit? long
Units: kilobytes per second
Related ioctls: /proc/sys/dev/raid/speed_limit_max

Short description: minumun guaranteed array reconstruction speed (in KB/s).

Description: minimun guaranteed array reconstruction speed for RAID-0, 
RAID-5 and the ones derived from them. When the array is reconstructing, 
this parameter sets the minimun reconstruction speed of the array, 
borrowing I/O time from applications if needed. Don't set this parameter 
too high or your system will be very little responsive when the array is
reconstructing (give applications I/O some room :).

Is this something reasonable to ?.

Regards.

--
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

