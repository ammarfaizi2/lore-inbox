Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135328AbREHUvv>; Tue, 8 May 2001 16:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135363AbREHUvk>; Tue, 8 May 2001 16:51:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5811 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135328AbREHUts>;
	Tue, 8 May 2001 16:49:48 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15096.23421.564537.144351@pizda.ninka.net>
Date: Tue, 8 May 2001 13:47:57 -0700 (PDT)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.4: mmap() fails for certain legal requests
In-Reply-To: <Pine.GSO.3.96.1010508214647.4713B-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <Pine.GSO.3.96.1010508214647.4713B-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Maciej W. Rozycki writes:
 >  The bug was discovered when tracking down the reason of dlopen() failures
 > when called from statically linked binaries on MIPS/Linux.  The patch
 > fixes them.

There are several get_unmapped_area() implementations besides the
standard one (search for HAVE_ARCH_UNMAPPED_AREA).  Please fix
them up too.

Later,
David S. Miller
davem@redhat.com
