Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311753AbSCTQTF>; Wed, 20 Mar 2002 11:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311745AbSCTQSv>; Wed, 20 Mar 2002 11:18:51 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:35466
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S311761AbSCTQSb>; Wed, 20 Mar 2002 11:18:31 -0500
Date: Wed, 20 Mar 2002 09:17:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Helge Hafting <helgehaf@aitel.hist.no>, Nicolas Pitre <nico@cam.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
Message-ID: <20020320161753.GE3762@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.44.0203191533360.3615-100000@xanadu.home> <3C985A46.D3C73301@aitel.hist.no> <20020320155933.GC4911@mh57.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 04:59:33PM +0100, Martin Hermanowski wrote:
> On Wed, Mar 20, 2002 at 10:45:42AM +0100, Helge Hafting wrote:
> > Nicolas Pitre wrote:
> > 
> >>> Removable media?
> >> 
> >> Most if not all removable media are not ment to be used with JFFS2.
> > 
> > Nothing is _meant_ to be exploited either.  Someone could
> > create a cdrom with jffs2 (linux don't demand that cd's use iso9660)
> > with an intent to make trouble.  crc's and such would match the 
> > bad compressed stuff.  Nothing unusual seems to happen, but
> > using the cd installs a back door as the fs uncompresses stuff.
> 
> What about ZISOFS? IIRC the files are compressed with gzip und
> decompressed on the fly.

ZISOFS falls into the same case that 2.5 does.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
