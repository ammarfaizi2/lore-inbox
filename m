Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbTDSTvG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTDSTvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 15:51:06 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263445AbTDSTvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 15:51:05 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304192005.h3JK5xm2000164@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sat, 19 Apr 2003 21:05:59 +0100 (BST)
Cc: john@grabjohn.com (John Bradford),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20030419185201.55cbaf43.skraw@ithnet.com> from "Stephan von Krawczynski" at Apr 19, 2003 06:52:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I wonder whether it would be a good idea to give the linux-fs
> > > (namely my preferred reiser and ext2 :-) some fault-tolerance.
> > 
> > Fault tollerance should be done at a lower level than the filesystem.
> 
> I know it _should_ to live in a nice and easy world. Unfortunately
> real life is different. The simple question is: you have tons of
> low-level drivers for all kinds of storage media, but you have
> comparably few filesystems. To me this sound like the preferred
> place for this type of behaviour can be fs, because all drivers
> inherit the feature if it lives in fs.

Unless you write a tar archive to the raw device :-)

John.
