Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUCKOpc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUCKOpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:45:32 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64701 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261375AbUCKOp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:45:27 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.4-rc-bk3: hdparm -X locks up IDE
Date: Thu, 11 Mar 2004 15:52:26 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200403111614.08778.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200403111614.08778.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403111552.26315.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 of March 2004 15:14, Denis Vlasenko wrote:
> I discovered that hdparm -X <mode> /dev/hda can lock up IDE
> interface if there is some activity.

Known bug and is on TODO but fixing it ain't easy.
Thanks for a report anyway.

Regards,
Bartlomiej

