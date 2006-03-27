Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWC0UF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWC0UF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWC0UF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:05:27 -0500
Received: from colibri.its.uu.se ([130.238.4.154]:18309 "EHLO
	colibri.its.uu.se") by vger.kernel.org with ESMTP id S1751117AbWC0UF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:05:27 -0500
From: "Alfred M. Szmidt" <ams@gnu.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: cascardo@minaslivre.org, tytso@mit.edu, adilger@clusterfs.com,
       sho@bsd.tnes.nec.co.jp, cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Laurent.Vivier@bull.net,
       sct@redhat.com
In-reply-to: <1143489301.15697.9.camel@orbit.scot.redhat.com> (sct@redhat.com)
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Reply-to: ams@gnu.org
References: <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
	 <20060316183549.GK30801@schatzie.adilger.int>
	 <20060316212632.GA21004@thunk.org>
	 <20060316225913.GV30801@schatzie.adilger.int>
	 <20060318170729.GI21232@thunk.org>
	 <20060320063633.GC30801@schatzie.adilger.int>
	 <1142894283.21593.59.camel@orbit.scot.redhat.com>
	 <20060320234829.GJ6199@schatzie.adilger.int>
	 <1142960722.3443.24.camel@orbit.scot.redhat.com>
	 <20060321183822.GC11447@thunk.org>
	 <20060325145139.GA5606@cascardo.localdomain> <1143489301.15697.9.camel@orbit.scot.redhat.com>
Message-Id: <20060327200518.0413A44002@Psilocybe.Update.UU.SE>
Date: Mon, 27 Mar 2006 22:05:18 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Now, a non-Hurd system is not going to have any use for the gnu.*
   xattr semantics, as translator is a Hurd-specific concept.

gnu.* doesn't just concern itself with translators, it can also be
gnu.author (or some such) which is a normal UID, which GNU/Linux can
support without any problems.
