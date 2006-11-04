Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965290AbWKDLNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbWKDLNs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 06:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWKDLNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 06:13:47 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:8872 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S965290AbWKDLNr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 06:13:47 -0500
Date: Sat, 4 Nov 2006 03:13:46 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <20061104105302.GB16991@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.64.0611040313280.28640@twinlark.arctic.org>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.64.0611031057410.26057@twinlark.arctic.org>
 <20061104105302.GB16991@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="131011217-1459634866-1162638826=:28640"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--131011217-1459634866-1162638826=:28640
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Sat, 4 Nov 2006, Jörn Engel wrote:

> On Fri, 3 November 2006 11:00:58 -0800, dean gaudet wrote:
> > 
> > it seems to me that you only need to be able to represent a range of the 
> > most recent 65536 crashes... and could have an online process which goes 
> > about "refreshing" old objects to move them forward to the most recent 
> > crash state.  as long as you know the minimm on-disk crash count you can 
> > use it as an offset.
> 
> You really don't want to go down that path.  Doubling the storage size
> will double the work necessary to move old objects - hard to imagine a
> design that scales worse.

there's no doubling of storage size required.

-dean
--131011217-1459634866-1162638826=:28640--
