Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263225AbUDYTrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUDYTrN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 15:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUDYTrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 15:47:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49554 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263225AbUDYTrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 15:47:11 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Sebastian Witt <se.witt@gmx.net>
Subject: Re: PROBLEM: Oops when using both channels of the PDC20262
Date: Sun, 25 Apr 2004 21:47:05 +0200
User-Agent: KMail/1.5.3
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com
References: <40898ADA.8020708@hasw.net> <200404250331.25606.bzolnier@elka.pw.edu.pl> <408BFD32.7090202@hasw.net>
In-Reply-To: <408BFD32.7090202@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404252147.05725.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 of April 2004 20:02, Sebastian Witt wrote:
> Bartlomiej Zolnierkiewicz wrote:
>  > Please return back to 2.6.5 and try this patch, it disables PIO
>  > autotune. It fixed hangs for people disabling Promise BIOS but...
>  >
>  >  linux-2.6.6-rc2-bk1-bzolnier/drivers/ide/pci/pdc202xx_old.c |    2 +-
>  >  1 files changed, 1 insertion(+), 1 deletion(-)
>  >  ...
>
> Thanks, this patch works. I've tested now multiple times a 2.6.5 kernel
> with and without this patch. The BIOS of my controller is also disabled
> if this is important...

Thanks.  Can you retest with enabled BIOS?

Please also send me output output of 'cat /proc/ide/ide2/config'
and 'cat /proc/ide/ide3/config' before and after applying this patch.

Cheers,
Bartlomiej

