Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbTL2XtN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbTL2XtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:49:13 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:18116 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S265478AbTL2XtL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:49:11 -0500
Date: Tue, 30 Dec 2003 00:49:02 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Joshua Schmidlkofer <kernel@pacrimopen.com>
Cc: Samuel Flory <sflory@rackable.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux@3ware.com
Subject: Re: 3ware driver broken with 2.4.22/23 ?
Message-ID: <20031229234902.GL916@mail.muni.cz>
References: <20031221112113.GE916@mail.muni.cz> <3FE645E3.30602@rackable.com> <1072503925.27022.222.camel@menion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1072503925.27022.222.camel@menion.home>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 09:45:25PM -0800, Joshua Schmidlkofer wrote:
> 
> >    Generally not with such a small rev difference.  You could try the 
> > latest driver, and firmware in the 7.7.  The driver source is on the Red 
> > Hat drivers disk.  You should be able to drop in the .c, and .h in 
> > drivers/scsi, and recompile.
> > http://3ware.com/support/download.asp?code=5&id=7.7.0&softtype=Driver&releasenotes=&os=Windows
> > 
> > PS- Personally I'd suspect an XFS bug.  Try reiserfs.  I've been running 
> > 2.4.23pres, and 2.4.23 on hundreds of 3ware of numerous different types. 
> >   With no issue with the prior firmware release.
> 
> There are a lot of people, running RAID5 3ware's w/ Terrabyte arrays.  I
> don't want to say it is not an XFS bug, but I find that highly suspect. 

Well, with ext3 parition iozone program finishes OK. So it looks like some XFS
bug.

-- 
Luká¹ Hejtmánek
