Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUBYCBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 21:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbUBYB7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:59:17 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:11262 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262352AbUBYB6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:58:49 -0500
To: Matthew Wilcox <willy@debian.org>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
       Jeremy Higdon <jeremy@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.6.2, Partition support for SCSI CDROM...
References: <40396134.6030906@realitydiluted.com>
	<20040222190047.01f6f024.akpm@osdl.org>
	<40396E8F.4050307@realitydiluted.com>
	<20040224061130.GC503530@sgi.com>
	<403B8108.6080606@realitydiluted.com>
	<20040224170906.GQ25779@parcelfarce.linux.theplanet.co.uk>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 25 Feb 2004 10:58:37 +0900
In-Reply-To: <20040224170906.GQ25779@parcelfarce.linux.theplanet.co.uk>
Message-ID: <buoishvyl6a.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:
> sr0 whole disc
> sr0a ... sr0o partitions
> sr1, sr1a ... sr1o
> 
> It's probably too late to be consistent with discs and call them
> sra, sra1, ... sra15
> srb, srb1, ... srb15

The (BSDish) xx0a convention is arguably better anyway (because the
various parts of the name split naturally along the letter-digit
boundaries); I never quite figured out why linux used the convention it
does for disks.

[Of course consistency generally wins out over niceness, but where
consistency isn't an option...]

-Miles
-- 
`The suburb is an obsolete and contradictory form of human settlement'
