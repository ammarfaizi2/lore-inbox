Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUGZWME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUGZWME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUGZWME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:12:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:20909 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265910AbUGZWMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:12:01 -0400
Date: Mon, 26 Jul 2004 15:09:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, viro@parcelfarce.linux.theplanet.co.uk,
       jgarzik@pobox.com, mikpe@csd.uu.se, dgilbert@interlog.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Message-Id: <20040726150924.7bc68188.akpm@osdl.org>
In-Reply-To: <20040714183335.GG7308@fs.tum.de>
References: <200407141216.i6ECGHxg008332@harpo.it.uu.se>
	<40F562FC.50806@pobox.com>
	<20040714165419.GF7308@fs.tum.de>
	<200407141931.12249.bzolnier@elka.pw.edu.pl>
	<20040714183335.GG7308@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> I'm not yet 100% sure whether it's correct, so please double-check it.
> 
> 
> 
>  [patch] kill local sg_ms_to_jif/sg_jif_to_ms functions and use
>          msecs_to_jiffies/jiffies_to_msecs instead

Looks good here - thanks.
