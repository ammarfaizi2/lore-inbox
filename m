Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbTGHOrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267260AbTGHOrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 10:47:17 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:57863 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S265797AbTGHOrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 10:47:16 -0400
Date: Wed, 9 Jul 2003 01:00:00 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@osdl.org>, <jgarzik@pobox.com>, <sds@epoch.ncsc.mil>,
       <torvalds@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       <hch@infradead.org>, <greg@kroah.com>, <chris@wirex.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add SELinux module to 2.5.74-bk1
In-Reply-To: <1057671907.4352.13.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Mutt.LNX.4.44.0307090059020.8438-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jul 2003, Alan Cox wrote:

> On Maw, 2003-07-08 at 11:09, Andrew Morton wrote:
> > Comparing the complexity (size) of this code with the q-n-d hash tables
> > which are currently used one does wonder how useful it all will be.  The
> > additional indirections are not needed with q-n-d hashes.
> 
> Are these new hashes immune to deliberate attack (witness the network
> routing hash paper)

This is just hash table management code, hash functions are supplied by 
the caller (e.g. they could use jhash).


- James
-- 
James Morris
<jmorris@intercode.com.au>

