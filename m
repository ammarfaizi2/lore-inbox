Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbTJUOxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 10:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbTJUOxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 10:53:08 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:18165 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263114AbTJUOxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 10:53:06 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: James Finnie <jf1@IMERGE.co.uk>
Subject: Re: VIA IDE performance under 2.6.0-test7/8?
Date: Tue, 21 Oct 2003 16:55:55 +0200
User-Agent: KMail/1.5.4
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <C0D45ABB3F45D5118BBC00508BC292DB016038F5@imgserv04>
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB016038F5@imgserv04>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310211655.55369.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 of October 2003 16:37, James Finnie wrote:
> Hi guys;
>
> Am having trouble getting decent IDE performance from the 2.6.0-test8
> kernel (tested with 2.6.0-test7 kernel also, same issue).  The platform is
> VIA EPIA-ME6000 - with a VIA VT8235 southbridge.  Under 2.4.21 I get around
> 40Mb/s in hdparm -t and 70Mb/s for hdparm -T.  Under the 2.6.0-test7/8 I
> only manage 13Mb/s & 52Mb/s respectively!  I've attached my .config, and
> the output of /proc/ide/via, dmesg, and hdparm info.  I don't think I'm
> doing anything particularly stupid here, but if I am, hit me with a wet
> fish please :)

Does 'hdparm -a 512 /dev/hd?' help?
--bartlomiej

