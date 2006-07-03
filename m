Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWGCKZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWGCKZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWGCKZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:25:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751085AbWGCKZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:25:49 -0400
Date: Mon, 3 Jul 2006 03:25:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Carsten Otto <cotto@hobbit.neveragain.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm5 crashes with AHCI error (libata)
Message-Id: <20060703032542.6271067f.akpm@osdl.org>
In-Reply-To: <20060703094315.GA36774@hobbit.neveragain.de>
References: <20060703094315.GA36774@hobbit.neveragain.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 11:43:15 +0200
Carsten Otto <cotto@hobbit.neveragain.de> wrote:

> Hello!
> 
> Please note my other current problem, because it might be related to
> this. The thread has the title "Huge problem with XFS/iCH7R".
> 
> I tried booting 2.6.17-mm5, but got the following error message:
> http://c-otto.de/fehler/SANY1138.JPG

That was a PCI/MSI screwup in Greg's tree.  Please try -mm6, from which I
reverted all that.

> With 2.6.17.2 I can boot, but have following problems:
> - directly before the booting process I did xfs_repair with the latest
>   version (2.8.something) of xfs_repair
> - one _very_ huge (and important) directory disappeared
> - the dirs in /lost+found2 (manually renamed from lost+found) can still
>   not be deleted (seee previous thread)
> 
> You can find my detailled system specs in my previous thread.

You should copy xfs@oss.sgi.com and/or xfs-masters@oss.sgi.com on XFS
reports.

