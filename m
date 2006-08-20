Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWHTR7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWHTR7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWHTR7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:59:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30873 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751085AbWHTR7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:59:07 -0400
Subject: Re: [Patch] Signedness issue in drivers/scsi/ipr.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, brking@us.ibm.com
In-Reply-To: <1156014835.19657.3.camel@alice>
References: <1156014835.19657.3.camel@alice>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:20:14 +0100
Message-Id: <1156098014.4051.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-08-19 am 21:13 +0200, ysgrifennodd Eric Sesterhenn:
> hi,
> 
> gcc 4.1 with some extra warnings show the following:
> 
> drivers/scsi/ipr.c:6361: warning: comparison of unsigned expression < 0 is always false
> drivers/scsi/ipr.c:6385: warning: comparison of unsigned expression < 0 is always false
> drivers/scsi/ipr.c:6415: warning: comparison of unsigned expression < 0 is always false
> 

Acked-by: Alan Cox <alan@redhat.com>

