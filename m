Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVB1NeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVB1NeO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVB1NeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:34:11 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:56462 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261591AbVB1Nd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:33:56 -0500
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch ide-dev 4/9] add ide_task_init_flush() helper
Date: Sun, 27 Feb 2005 17:23:02 +0100
User-Agent: KMail/1.7.1
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.58.0502241540250.13534@mion.elka.pw.edu.pl> <20050227045637.GC25723@htj.dyndns.org>
In-Reply-To: <20050227045637.GC25723@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502271723.02313.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Sunday 27 February 2005 05:56, Tejun Heo wrote:
>  Hello,
> 
>  Just one minor thing.  Doesn't moving ide_task_s upward belong to
> patch #7?

It is needed for ide_task_init_flush() prototype.

> > +void ide_task_init_flush(ide_drive_t *, ide_task_t *);
