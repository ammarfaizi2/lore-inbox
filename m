Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTJ3Roq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 12:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTJ3Roq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 12:44:46 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64129 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262695AbTJ3Roo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 12:44:44 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
Date: Thu, 30 Oct 2003 18:48:19 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <200310301601.55588.schlicht@uni-mannheim.de>
In-Reply-To: <200310301601.55588.schlicht@uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310301848.19065.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Jens - IDE TCQ maintainer 8) added to cc: ]

On Thursday 30 of October 2003 16:01, Thomas Schlichter wrote:
> Hello,

Hi,

Could you also send dmesg output and retry with vanilla -test9?

--bartlomiej

> today I tried to test TCQ with the linux-2.6.0-test9-mm1 kernel. The
> config.gz is attached. But after enabling TCQ with 'hdparm -Q1 /dev/hda'
> newly started processes die due to a received SIGSEGV. No bad kernel
> messages appear...
>
> Disabling TCQ again doesn't help, only e reboot does...
> When I let the kernel enable TCQ at boot time, it set the TCQ buffer depth
> to 8 and even the init script was killed!

