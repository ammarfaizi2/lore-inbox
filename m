Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267990AbUHPWdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267990AbUHPWdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUHPWcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:32:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:55199 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267993AbUHPWb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:31:59 -0400
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8.1-mm1
Date: Tue, 17 Aug 2004 00:30:41 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
In-Reply-To: <20040816143710.1cd0bd2c.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408170030.41049.bzolnier@elka.pw.edu.pl>
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Monday 16 August 2004 23:37, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8
>.1-mm1

> iteraid.patch
>   ITE RAID driver

Please don't push this upstream, it duplicates _a lot_ of functionality 
present in drivers/ide / libata (Alan Cox has native drivers/ide driver,
although I would still prefer libata based driver) and contains code for RAID 
metadata handling which should belong to user-space.
