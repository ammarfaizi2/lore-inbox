Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVFMPAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVFMPAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVFMPAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:00:18 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:54402 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261598AbVFMPAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:00:05 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: =?ISO-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050613145000.GA12057@gmail.com>
References: <20050526173518.GA9132@gmail.com>
	 <1117463938.4913.3.camel@mulgrave> <20050530150950.GA14351@gmail.com>
	 <1117467248.4913.9.camel@mulgrave> <20050530160147.GD14351@gmail.com>
	 <1117477040.4913.12.camel@mulgrave> <20050530190716.GA9239@gmail.com>
	 <1118081857.5045.49.camel@mulgrave> <20050607085710.GB9230@gmail.com>
	 <1118590709.4967.6.camel@mulgrave>  <20050613145000.GA12057@gmail.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 09:59:43 -0500
Message-Id: <1118674783.5079.9.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello, I have applied your two patches against 2.6.12-rc6 (the 
> http://parisc-linux.org/~jejb/scsi_diffs/scsi-misc-2.6.diff and the last
> one you sent per email) and I get this now :

Actually, the kernel appears to be wrong:

> Linux version 2.6.12-rc5 (root@gregoire) (gcc version 3.4.3 20041125 (Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #4 Mon Jun 6 20:29:04 CEST 2005
                      ^^^^

It's also not showing any of the debugging information in the patch, so
I think you might not be booted on the correct kernel.

James


