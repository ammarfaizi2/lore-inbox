Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTLVKkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 05:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTLVKkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 05:40:41 -0500
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:30955 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264369AbTLVKkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 05:40:40 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16358.51721.108693.383647@wombat.chubb.wattle.id.au>
Date: Mon, 22 Dec 2003 21:40:09 +1100
To: Dale Amon <amon@vnl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there still at 2TB limit?
In-Reply-To: <20031221121158.GA5126@vnl.com>
References: <20031221010112.GX25351@vnl.com>
	<20031221101406.GA3211@localhost>
	<20031221121158.GA5126@vnl.com>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dale" == Dale Amon <amon@vnl.com> writes:

Dale> On Sun, Dec 21, 2003 at 11:14:06AM +0100, Jose Luis Domingo
Dale> Lopez wrote:
>> You will also need filesystems that support that big sizes and can
>> hold big files on them, have a look at the following URL for more
>> information: http://www.suse.de/~aj/linux_lfs.html

Dale> Thanks. I notice the notes there are quite old. Are there
Dale> libraries available now that work with LFS?

Yes.  Most glibc are distributed compiled with _LARGEFILE64 support.

See also http://www.gelato.unsw.edu.au/IA64wiki/LargeBlockDevices
I haven't got around to updating for 2.6.0, but the 2.5 notes still
apply.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
