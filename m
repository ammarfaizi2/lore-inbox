Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbUJ3Mco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUJ3Mco (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 08:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUJ3Mcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 08:32:31 -0400
Received: from a4.complang.tuwien.ac.at ([128.130.173.65]:30895 "EHLO
	a4.complang.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261161AbUJ3McV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 08:32:21 -0400
Subject: up-to-date locate and glimpse
To: linux-kernel@vger.kernel.org
Date: Sat, 30 Oct 2004 14:32:20 +0200 (CEST)
From: "Anton Ertl" <anton@mips.complang.tuwien.ac.at>
Reply-To: anton@mips.complang.tuwien.ac.at
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1CNsP6-0001f0-2D@a4.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rastislav Levrinc and Peter Robinson, two of our students have written
kernel patches and user-level daemons that allow keeping the locate
and/or the glimps database up-to-date.  You can find them through

http://www.complang.tuwien.ac.at/anton/rlocate/

Caveats: 

- This is stuff done for something like a term project, i.e., to
proof-of-concept standards.  On the positive side, we had no crashes
or other unpleasant experiences when we tried it (but we did not try
much).  Rastislav Levrinc has written that he wants to maintain this
stuff, but I have not yet seen much activity in that direction.

- The version for the 2.4 kernel (rlocate) does not see file system
activity coming through NFS on an NFS server.  It also does not
support glimpse.

- Rlocate does not support slocate security features.  Glimpse does
not have similar security features at all (AFAIK).

  - anton
