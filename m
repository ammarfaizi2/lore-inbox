Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUI0NQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUI0NQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 09:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUI0NQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 09:16:06 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:23710 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S265795AbUI0NP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 09:15:56 -0400
Date: Mon, 27 Sep 2004 15:15:54 +0200 (CEST)
From: =?iso-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
To: linux-kernel@vger.kernel.org
Subject: [Announce] Umbrella 0.4.1
Message-ID: <Pine.LNX.4.61.0409271514520.12466@homer.cs.aau.dk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-511570494-493682217-1096290954=:12466"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---511570494-493682217-1096290954=:12466
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi all!

We are now pleased to announce the release of Umbrella version 0.4.1,=20
which
really boosts performance of Umbrella =3D:-D

Umbrella implements a combination of process based mandatory access
control and authentication of files.
(more information on http://umbrella.sf.net)

The major changes include the following:
* Name refactoring in the code:
   "Additional child restrictions" is now called level2/l2 and
   "Restrictions" is now called level1/l1

* A global hash table has been implemented, to store the indexes of the
   static level1 restrictions. This boosts performance dramatically, as
   this was done by tons of string compares in earlier versions :)

* The syscalls works for UML once again

* The level 1 and level 2 hash functionality have been put into seperate
   files, namely umb_hash_l1.c and umb_hash_l2.c

Umbrella 0.4.1 can be downloaded from SourceForge here:
http://prdownloads.sourceforge.net/umbrella/umbrella-0.4.1.tar.bz2?download


Enjoy,
Kristian.


--
Kristian S=C3=B8rensen
- The Umbrella Project
    http://umbrella.sourceforge.net
---511570494-493682217-1096290954=:12466--
