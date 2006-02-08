Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWBHLzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWBHLzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 06:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWBHLzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 06:55:46 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36039 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964994AbWBHLzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 06:55:46 -0500
Subject: Re: libata pata atapi  errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43E95415.40501@comcast.net>
References: <43E95415.40501@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Feb 2006 11:57:54 +0000
Message-Id: <1139399874.26270.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-07 at 21:14 -0500, Ed Sweetman wrote:
> Assertion failed! qc->n_elem > 
> 0,drivers/scsi/libata-core.c,ata_fill_sg,line=2586
>    (repeated many times)


Jeff was looking at some core bugs in this area. Its one of the ones I
can I think safely disclaim responsibility for (that and the fact that a
timeout of a command early on in 2.6.16-rc causes an oops)

Alan

