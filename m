Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUJMDmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUJMDmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 23:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUJMDmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 23:42:53 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:28352 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268293AbUJMDmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 23:42:52 -0400
Subject: Re: 4level page tables for Linux II
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Content-Type: text/plain
Organization: 
Message-Id: <1097638599.2673.9668.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Oct 2004 23:36:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm...

pml4, pgd, pmd, pte  (kernel names)
PML4E, PDPE, PDE, PTE   (AMD hardware names)

It's kind of a mess, isn't it? It was bad enough
with the "pmd" (page middle directory, ugh) being
some random invention and everything being generally
in conflict with real hardware naming. Now you've
come up with a fourth name.

Notice that you've resorted to using a number.
Why not do that for the others too? It would
bring some order to this ever-growing collection
of arbitrary names. Like this:

pd4, pd3, pd2, pd1


