Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTFJNhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTFJNhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:37:39 -0400
Received: from kempelen.iit.bme.hu ([152.66.241.120]:16014 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S261798AbTFJNhe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:37:34 -0400
Date: Tue, 10 Jun 2003 15:51:09 +0200 (MET DST)
From: =?ISO-8859-2?Q?P=E1sztor_Szil=E1rd?= <silicon@inf.bme.hu>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.5 patch] let COMX depend on PROC_FS
In-Reply-To: <20030610142614.A25666@infradead.org>
Message-ID: <Pine.GSO.4.00.10306101549360.13214-100000@kempelen.iit.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig:
> So what about fixing it instead?  The usage of proc_get_inode is broken
> and so is the whole profs mess in the comx driver.  If you want to keep
> the API you need to add a ramfs-style filesystem instead of abusing
> procfs.

Is the case the same with the SCSI drivers, IDE drivers, network core,
filesystems and everything that creates directories and file entries in
procfs?

              ---------------------------------------------------
              |  Widows '95 - The Micro$oft Solution Preventer  |
              ---------------------------------------------------

