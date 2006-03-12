Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWCLVqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWCLVqQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbWCLVqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:46:16 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13286 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751694AbWCLVqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:46:15 -0500
Subject: Re: Linux v2.6.16-rc6
From: Lee Revell <rlrevell@joe-job.com>
To: Paul Blazejowski <paulb@blazebox.homeip.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <1142189154.21274.20.camel@blaze.homeip.net>
References: <1142189154.21274.20.camel@blaze.homeip.net>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 16:46:10 -0500
Message-Id: <1142199970.25358.173.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 13:45 -0500, Paul Blazejowski wrote:
> On recent kernel 2.6.15.6 (or any 2.6.15.x) and latest testing
> 2.6.16-rc6 libata detects and sets wrong UDMA modes for one of the
> SATA-1 drives. This seems to be a bug.
> 
> My setup is as follows:
> 
> ASUS A8N-SLI-Premium Nforce4 mainboard
> AMD Athlon X2 CPU running SMP
> GCC 3.3.6
> Slackware 10.2 Linux
> 
> The drives are used in RAID1 array (dmraid), they are WDC-WD2000JD
> series purchased few months apart. Sata is compiled in the kernel as
> module sata_nv and functions properly, no errors or any other anomalies
> were noticed but the UDMA mode detection seem wrong on the second drive.
> 
> Drive one reports ata3: dev 0 configured for UDMA/100 while drive two
> ata4: dev 0 configured for UDMA/133

This bug report is still somewhat unclear.

What are the correct modes you expect to see?

Lee

