Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311718AbSCTQAf>; Wed, 20 Mar 2002 11:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311721AbSCTQAZ>; Wed, 20 Mar 2002 11:00:25 -0500
Received: from moutng0.kundenserver.de ([212.227.126.170]:15605 "EHLO
	moutng0.schlund.de") by vger.kernel.org with ESMTP
	id <S311718AbSCTQAI>; Wed, 20 Mar 2002 11:00:08 -0500
Date: Wed, 20 Mar 2002 16:59:33 +0100
From: Martin Hermanowski <martin@mh57.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Nicolas Pitre <nico@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
Message-ID: <20020320155933.GC4911@mh57.net>
Mail-Followup-To: Helge Hafting <helgehaf@aitel.hist.no>,
	Nicolas Pitre <nico@cam.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203191533360.3615-100000@xanadu.home> <3C985A46.D3C73301@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-PGP-Fingerprint: 3A8B 6A9A 3353 8CE7 9C95  31C8 0277 FA58 1FEA 0DF4
X-PGP-Key-ID: 1FEA0DF4
X-PGP-Key-At: http://empyreum.de/pgp-keys/MH.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 10:45:42AM +0100, Helge Hafting wrote:
> Nicolas Pitre wrote:
> 
>>> Removable media?
>> 
>> Most if not all removable media are not ment to be used with JFFS2.
> 
> Nothing is _meant_ to be exploited either.  Someone could
> create a cdrom with jffs2 (linux don't demand that cd's use iso9660)
> with an intent to make trouble.  crc's and such would match the 
> bad compressed stuff.  Nothing unusual seems to happen, but
> using the cd installs a back door as the fs uncompresses stuff.

What about ZISOFS? IIRC the files are compressed with gzip und
decompressed on the fly.

MfG
Martin

-- 
PGP/GPG encrypted mail preferred, see header
,-- 
| Nur tote Fische schwimmen mit dem Strom
`--
