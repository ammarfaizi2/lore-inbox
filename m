Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVCNRo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVCNRo4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVCNRnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:43:23 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:47010 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261650AbVCNRmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:42:18 -0500
Subject: Re: Repeatable IDE Oops for 2.6.11 (ide-scsi vs ide-cdrom)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul <set@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20050314065508.GA7974@squish.home.loc>
References: <20050314065508.GA7974@squish.home.loc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110822016.15927.136.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 14 Mar 2005 17:40:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-03-14 at 06:55, Paul wrote:
> # cat driver
> > ide-cdrom version 4.61
> # echo ide-scsi > driver
> # cat driver

This has always been unsafe. Its something I suggested was removed a
long time ago because the locking for it is unfixable.

Alan

