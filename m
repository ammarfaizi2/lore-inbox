Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWBHQVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWBHQVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWBHQVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:21:47 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:14099 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1161095AbWBHQVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:21:46 -0500
Date: Wed, 8 Feb 2006 16:21:45 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH 02/17] mips: namespace pollution - mem_... -> __mem_...
 in io.h
In-Reply-To: <20060208161435.GH27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64N.0602081615280.27639@blysk.ds.pg.gda.pl>
References: <E1F6jSx-0002TE-Ur@ZenIV.linux.org.uk>
 <Pine.LNX.4.64N.0602081059020.27639@blysk.ds.pg.gda.pl>
 <20060208161435.GH27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Al Viro wrote:

> >  Then the corresponding ones with no "mem_" prefix (these for the PCI I/O 
> > port space) should be prefixed with "__" for consistency as well.
> 
> Huh???
> 
> Things like outb(), etc. *are* public; mem_... ones are not. 

 I mean if we rename e.g. mem_ioswabb() to __mem_ioswabb(), then we should 
rename ioswabb() to __ioswabb() as well.  Sorry for not having been clear 
enough, but I have assumed it is obvious.

  Maciej
