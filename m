Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbUBUAxr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUBUAxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:53:47 -0500
Received: from mid-2.inet.it ([213.92.5.19]:55770 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S261459AbUBUAxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:53:46 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-mm1 and aic7xxx
Date: Sat, 21 Feb 2004 01:53:38 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402192234.53855.cova@ferrara.linux.it> <20040219162102.0b699698.akpm@osdl.org>
In-Reply-To: <20040219162102.0b699698.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200402210153.38553.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 01:21, venerdì 20 febbraio 2004, Andrew Morton ha scritto:

> > I've also noticed (only with 2.6.3-mm1) a "PCI BIOS passed non existent
> > PCI BUS 0!" message when it probes ICH5, i.e.
>
> Could be an acpi thing.  If you have time, could you try
>
> 	patch -p1 -R < bk-acpi.patch
>
> and see if that helps?

Tried, the error message is disappeared (but my kernel still hangs on scsi 
detection, so I'm unable if this has other effects :) )


-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
