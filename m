Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUGMKaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUGMKaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 06:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUGMKaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 06:30:05 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:29963 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264770AbUGMK3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 06:29:14 -0400
To: Chris Wedgwood <cw@f00f.org>
Cc: Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>,
       L A Walsh <lkml@tlinx.org>
From: Tim Connors <tconnors@astro.swin.edu.au>
Subject: Re:  XFS: how to NOT null files on fsck?
In-reply-to: <20040713095300.GA2986@taniwha.stupidest.org>
References: <20040713080950.GA1810@taniwha.stupidest.org> <E1BkJgc-0002Sb-O5@a4.complang.tuwien.ac.at> <20040713095300.GA2986@taniwha.stupidest.org>
X-Face: A>QmH)/u`[d}b.a5?Xq=L&d?Q}cF5x|wu#O_mAK83d(Tw,BjxX[}n4<13.e$"d!Gg(I%n8fL)I9fZ$0,8s3_5>iI]4c%FXg{CpVhuIuyI,W'!5Cl?5M,dL-*dHYs}K9=YQZCN-\2j1S>cU6XPXsQhz$x`M\ZEV}nPw'^jPc41FiwTQZ'g)xNK{2',](o5mrODBHe))
Message-ID: <slrn-0.9.7.4-25266-13316-200407132020-tc@hexane.ssi.swin.edu.au>
Date: Tue, 13 Jul 2004 20:27:30 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> said on Tue, 13 Jul 2004 02:53:00 -0700:
> at which point you've stomped on your file.  it's non uncommong for
> KDE to do this (even though the window would apparently be very small)

KDE is a peice of shit with regards to file handling.

It seems they never learnt the lessons of writing files in Unix that
have been learnt over the last 30 years.

How the hell can you afford to hose your entire WM because KDE decides
to write some obscure file at some time when the NFS servers just
happen to be temporarily down? What ever happened to the standard
practice of write to temp file, then atomic rename? What ever happened
to making backups of critical files before overwriting them? Furrfu.

Makes me glad I use a much more sane WM, but I pity those 3 users in
the space of a few minutes who lost all of their settings.

BTW, I have submitted the occasional bug to Debian because packages
will cause dataloss to an /etc file if the disk happens to run out at
the wrong moment (quite a common occurence for me). Furrfu people -
this is so bloody simple to get right.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
The prolonged application of polysyllabic vocabulary infallibly
exercises a deleterious influence on the fecundity of expression,
rendering the ultimate tendancy apocryphal.
