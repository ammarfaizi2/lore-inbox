Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTJWFUl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 01:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTJWFUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 01:20:40 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:26275 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261575AbTJWFUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 01:20:39 -0400
To: andersen@codepoet.org
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: srfs - a new file system.
References: <Pine.GSO.4.44.0310070757400.4688-100000@sundance.cse.ucsc.edu>
	<Pine.LNX.4.44_heb2.09.0310201031150.20172-100000@nexus.cs.bgu.ac.il>
	<20031022045708.GA5636@codepoet.org>
	<200310221605.h9MG5k37007196@turing-police.cc.vt.edu>
	<20031022193849.GA21188@codepoet.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 23 Oct 2003 14:20:21 +0900
In-Reply-To: <20031022193849.GA21188@codepoet.org>
Message-ID: <buod6cofs2y.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen <andersen@codepoet.org> writes:
> Not so much a potential BitKeeper customer, as pointing out that
> the distributed filesystems prople are attacking the same
> fundamental problem as the distributed version control folks.

It may be the same at some level, but there's an important difference:
distributed filesystems are usually (AFAIK) attempting to maintain the
illusion of a single global filesystem that looks more or less to the
users like a local filesystem, and usually just an average unixy
filesystem.  This is very, very, hard...

Distributed version control systems, OTOH, because they're at a somewhat
higher level, have the huge advantage of distinct operational boundaries
which are exposed the user and can be used to manage the distribution.
Since users are used to these boundaries, and they usually occur at
fairly obvious and reasonable places, this isn't such a burden on the
users.

-Miles
-- 
97% of everything is grunge
