Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTKKDmm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbTKKDml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:42:41 -0500
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:29080 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263303AbTKKDmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:42:40 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16304.23206.924374.529136@wombat.chubb.wattle.id.au>
Date: Tue, 11 Nov 2003 14:42:30 +1100
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Joseph Shamash <info@avistor.com>, Peter Chubb <peter@chubb.wattle.id.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
In-Reply-To: <20031111022140.GE2014@mis-mike-wstn.matchmail.com>
References: <16304.9647.994684.804486@wombat.chubb.wattle.id.au>
	<HBEHKOEIIJKNLNAMLGAOIECPDKAA.info@avistor.com>
	<20031111022140.GE2014@mis-mike-wstn.matchmail.com>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Mike" == Mike Fedyk <mfedyk@matchmail.com> writes:

> On Mon, Nov 10, 2003 at 06:12:06PM -0800, Joseph Shamash wrote:
>> 
>> What is the maximum partition size for a patched 2.4.x kernel, and
>> where are those patches?

Mike> I believe it is now 16TB per block device in 2.6, and patched
Mike> 2.4.

That's right for 32-bit systems with 4k pages.  For 64 bit systems the
limit is over 8 Exabytes.

You should note that software raid has smaller limits, as does the
LVM.  Also the 2.4 patches have seen *much* less testing than the 2.6
mainline (except possibly on the SGI Altix).

What exactly are you trying to do?

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
