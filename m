Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUBRDMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBRDMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:12:08 -0500
Received: from hera.kernel.org ([63.209.29.2]:48520 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262130AbUBRDMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:12:06 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
Date: Wed, 18 Feb 2004 03:11:32 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0ul54$45h$1@terminus.zytor.com>
References: <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk> <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402171251130.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077073892 4274 63.209.29.3 (18 Feb 2004 03:11:32 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 18 Feb 2004 03:11:32 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0402171251130.2154@home.osdl.org>
By author:    Linus Torvalds <torvalds@osdl.org>
In newsgroup: linux.dev.kernel
> 
> UCS-4 is as braindamaged as UCS-2 was, and for all the same reasons.
> 
> It's bloated, non-expandable, and not backwards compatible.
> 

UCS-4 is actually a very nice format for *internal processing*.  For
data interchange, it sucks eggs.

UCS-2 is historic.  It's successor, UTF-16, is one of the worst
horrors ever inflicted on mankind by Microsoft.

	-hpa
