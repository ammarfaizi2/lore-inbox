Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbUAQMFL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 07:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265903AbUAQMFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 07:05:10 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59901 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265603AbUAQMFF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 07:05:05 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: backblue <backblue@netcabo.pt>
Subject: Re: a7n8x-x
Date: Sat, 17 Jan 2004 13:08:48 +0100
User-Agent: KMail/1.5.3
References: <20040117102229.4747e7f8.backblue@netcabo.pt>
In-Reply-To: <20040117102229.4747e7f8.backblue@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171308.48641.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 of January 2004 11:22, backblue wrote:
> Hello,

Hi,

> For ppl with problems with a7n8x-x with chipset nforce2, that have problems
> with ide driver, and the machines hangs up, the solution it's upgrade the

People with SCSI also reported lockups.

> bios for the last release from the asus ftpd, i'm using version 1007, with
> 1005, that it's the default version, if we disable the suport in the
> kernel, for Nvidia id chipset, the machine works, but we dont have dma
> enable, and becomes impossible to work, and if we enable it, the machine

This only makes problem less frequent (as reported by other people).

> hangs up every time, in 2.4 series it crashes less, but in 2.6.1, if i just
> compile anything the machine goes down, just upgrade the bios to this
> version, if not resolve, try to disable the APIC suporte on bios. -

If BIOS upgrade helped please send 'lspci -vvv -xxx' output from system
after/before BIOS upgrade, so we can try to catch the problem and add a fix
to kernel (there is no BIOS update for some motherboards).

Thanks!

--bart

