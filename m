Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293277AbSCJV2g>; Sun, 10 Mar 2002 16:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293283AbSCJV20>; Sun, 10 Mar 2002 16:28:26 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61322 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293277AbSCJV2R>;
	Sun, 10 Mar 2002 16:28:17 -0500
Date: Sun, 10 Mar 2002 16:28:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rob Turk <r.turk@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <E16kAxQ-0007MV-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0203101623400.7778-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Mar 2002, Alan Cox wrote:

> Its trickier than that - because all your other semantics have to align,
> its akin to the undelete problem (in fact its identical). Do you version on
> a rewrite, on a truncate, only on an O_CREAT ?

Even better, what do you do upon link(2)?  Or rename(2) over one of the
versions...

VMS is not UNIX.  And union of these two will be hell - incompatible models,
let alone features.  "Well, I don't use <list of Unix features>" is not an
answer - other people have different sets of things they don't use and you
can be sure that every thing you don't care about is absolute must-have
for somebody else.

