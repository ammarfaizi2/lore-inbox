Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264964AbTL1DNT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 22:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTL1DNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 22:13:18 -0500
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:55804 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S264964AbTL1DNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 22:13:16 -0500
Subject: Re: 2.7 (future kernel) wish
From: Rob Love <rml@ximian.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Jim Crilly <jim@why.dont.jablowme.net>,
       Joshua Schmidlkofer <kernel@pacrimopen.com>,
       "David B. Stevens" <dsteven3@maine.rr.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FEE4929.4000500@backtobasicsmgmt.com>
References: <200312232342.17532.josh@stack.nl>
	 <20031226233855.GA476@hh.idb.hist.no>  <3FECCAF9.7070209@maine.rr.com>
	 <1072507896.27022.226.camel@menion.home>
	 <3FEE47F5.6090406@why.dont.jablowme.net>
	 <3FEE4929.4000500@backtobasicsmgmt.com>
Content-Type: text/plain
Message-Id: <1072581195.4042.13.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sat, 27 Dec 2003 22:13:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-27 at 22:08, Kevin P. Fleming wrote:

> Nope, when I put stuff onto a CF card via CF-to-USB adapter Windows 
> still buffers writes to the media while the user interface goes on about 
> its business. The only media that I've ever seen Windows use 
> synchronously is old-style floppy disks.

Yah, it really would not be smart to do all I/O synchronously.

It might be a neat idea to do the buffer writeback much sooner, but that
would require per-device writeback settings, which is ugh.

	Rob Love


