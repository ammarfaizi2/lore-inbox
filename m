Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbTAEBqU>; Sat, 4 Jan 2003 20:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbTAEBqU>; Sat, 4 Jan 2003 20:46:20 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:18193 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262418AbTAEBqR>; Sat, 4 Jan 2003 20:46:17 -0500
Date: Sun, 5 Jan 2003 02:54:44 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andreas Dilger <adilger@turbolabs.com>
Subject: Documentation/BK-usage/bksend problems?
Message-ID: <20030105015444.GE29511@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Andreas Dilger <adilger@turbolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is bksend in wide use?

I tried to use it to send a patch to ntp-stable with  the help of this
tool, and figured that the gnupatch part always omitted the first
version if you give it a range such as

bksend -r1.838..1.839.

The changes are fine, for 1.838 and 1.839, but the patch itself only
contains the effects of 1.839. The attached gzip_uu wrapped bk
"receive"able stuff is fine again and contains both ChangeSets.

It seems as though it would take "diff 1.839 against 1.838" for bk gnupatch
and "changesets 1.838 to 1.839 inclusively" for bk send.

If that matters:

BitKeeper/Free version is bk-2.1.6-pre5 20020330075529 for x86-glibc22-linux

-- 
Matthias Andree
