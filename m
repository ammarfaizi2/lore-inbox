Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312119AbSCTJrT>; Wed, 20 Mar 2002 04:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312120AbSCTJrJ>; Wed, 20 Mar 2002 04:47:09 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:43794 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S312119AbSCTJrA>; Wed, 20 Mar 2002 04:47:00 -0500
Message-ID: <3C985A46.D3C73301@aitel.hist.no>
Date: Wed, 20 Mar 2002 10:45:42 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.7 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Nicolas Pitre <nico@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
In-Reply-To: <Pine.LNX.4.44.0203191533360.3615-100000@xanadu.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre wrote:

> > Removable media?
> 
> Most if not all removable media are not ment to be used with JFFS2.

Nothing is _meant_ to be exploited either.  Someone could
create a cdrom with jffs2 (linux don't demand that cd's use iso9660)
with an intent to make trouble.  crc's and such would match the 
bad compressed stuff.  Nothing unusual seems to happen, but
using the cd installs a back door as the fs uncompresses stuff.

Helge Hafting
